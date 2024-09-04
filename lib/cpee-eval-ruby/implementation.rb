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
require_relative 'translation'

module CPEE
  module EvalRuby

    SERVER = File.expand_path(File.join(__dir__,'implementation.xml'))

    class DoIt < Riddl::Implementation #{{{
      def response

      end
    end #}}}
    class Structurize < Riddl::Implementation #{{{
      def response
        Riddl::Parameter::Complex('structurized','application/json',Utils::structurize_result(@p))
      end
    end #}}}

    def self::implementation(opts)
      Proc.new do
        on resource do
          on resource 'exec' do
            run DoIt, :put if put 'exec'
          end
          on resource 'structurize' do
            run Structurize, :orig if put
          end
        end
      end
    end

  end
end
