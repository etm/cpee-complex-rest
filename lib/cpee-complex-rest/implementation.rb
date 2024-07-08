# This file is part of CPEE-COMPLEX-REST.
#
# CPEE-COMPLEX-REST is free software: you can redistribute it and/or modify it
# under the terms of the GNU Lesser General Public License as published by the
# Free Software Foundation, either version 3 of the License, or (at your
# option) any later version.
#
# CPEE-COMPLEX-REST is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License
# for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with CPEE-COMPLEX-REST (file LICENSE in the main directory).  If not,
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

module CPEE
  module ComplexRest

    SERVER = File.expand_path(File.join(__dir__,'implementation.xml'))

    class DoIt < Riddl::Implementation #{{{
      def response
        op = @a[0]
        send = []
      end
    end #}}}

    def self::implementation(opts)
      Proc.new do
        on resource do
          run DoIt, :get if get 'fw'
          run DoIt, :post if post 'fw'
          run DoIt, :put if put 'fw'
          run DoIt, :delete if delete 'fw'
          run DoIt, :patch if patch 'fw'
        end
      end
    end

  end
end
