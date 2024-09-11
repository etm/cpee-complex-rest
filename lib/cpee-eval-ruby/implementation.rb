# This file is part of CPEE-EVAL-RUBY.
#
# CPEE-EVAL-RUBY is free software: you can redistribute it and/or modify it
# under the terms of the GNU Lesser General Public License as published by the
# Free Software Foundation, either version 3 of the License, or (at your
# option) any later version.
#
# CPEE-EVAL-RUBY is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License
# for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with CPEE-EVAL-RUBY (file LICENSE in the main directory).  If not,
# see <http://www.gnu.org/licenses/>.

require 'rubygems'
require 'cpee/value_helper'
require 'xml/smart'
require 'riddl/server'
require 'securerandom'
require 'base64'
require 'uri'
require 'redis'
require 'json'
require 'weel'
require_relative 'translation'

module CPEE
  module EvalRuby

    SERVER = File.expand_path(File.join(__dir__,'implementation.xml'))

    class DoIt < Riddl::Implementation #{{{
      def exec(mr,code,result=nil,headers=nil)
        mr.instance_eval(code)
      end

      def response
        code = @p.shift.value
        # code = code.read if code.respond_to? :read
        # code = Riddl::Protocols::Utils::unescape(code)
        dataelements = JSON::parse(@p.shift.value.read)
        local = nil
        local = JSON::parse(@p.shift.value.read) if @p[0].name == 'local'
        endpoints = JSON::parse(@p.shift.value.read)
        additional = JSON::parse(@p.shift.value.read)
        status = JSON::parse(@p.shift.value.read) if @p.any? && @p[0].name == 'status'
        status = WEEL::Status.new(status['id'],status['message']) if status
        call_result = JSON::parse(@p.shift.value.read) if @p.any? && @p[0].name == 'call_result'
        call_headers = JSON::parse(@p.shift.value.read) if @p.any? && @p[0].name == 'call_headers'

        # symbolize keys, because JSON
        dataelements.transform_keys!{|k| k.to_sym}
        local.first.transform_keys!{|k| k.to_sym} if local
        endpoints.transform_keys!{|k| k.to_sym}
        additional.transform_keys!{|k| k.to_sym}
        additional.each_value do |v|
          v.transform_keys!{|k| k.to_sym}
        end

        if status || call_result || call_headers
          struct = WEEL::ManipulateStructure.new(dataelements,endpoints,status,local,additional)
          exec struct, code, CPEE::EvalRuby::Translation::simplify_structurized_result(call_result), call_headers
          ret = []
          ret.push Riddl::Parameter::Simple.new('result','')

          res = {}
          struct.changed_data.each do |e|
            res[e] = struct.data[e]
          end
          ret.push Riddl::Parameter::Complex.new('changed_dataelements','application/json',JSON::generate(res)) if res.any?
          res = {}
          struct.changed_endpoints.each do |e|
            res[e] = struct.endpoints[e]
          end
          ret.push Riddl::Parameter::Complex.new('changed_endpoints','application/json',JSON::generate(res)) if res.any?
          ret.push Riddl::Parameter::Complex.new('changed_status','application/json',JSON::generate(status)) if struct.changed_status
          ret
        else
          struct = WEEL::ReadStructure.new(dataelements,endpoints,local,additional)
          res = exec struct, code
          Riddl::Parameter::Simple.new('result',res)
        end
      end
    end #}}}
    class Structurize < Riddl::Implementation #{{{
      def response
        Riddl::Parameter::Complex.new('structurized','application/json',JSON::generate(CPEE::EvalRuby::Translation::structurize_result(@p)))
      end
    end #}}}

    def self::implementation(opts)
      Proc.new do
        on resource do
          on resource 'exec' do
            run DoIt if put 'exec'
          end
          on resource 'structurize' do
            run Structurize if put
          end
        end
      end
    end

  end
end
