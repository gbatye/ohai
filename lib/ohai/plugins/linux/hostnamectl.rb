# frozen_string_literal: true
#
# Author:: Davide Cavalca (<dcavalca@fb.com>)
# Copyright:: Copyright (c) 2016 Facebook
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

Ohai.plugin(:Hostnamectl) do
  provides "hostnamectl"

  collect_data(:linux) do
    hostnamectl Mash.new unless hostnamectl

    hostnamectl_path = which("hostnamectl")
    if hostnamectl_path
      shell_out(hostnamectl_path).stdout.split("\n").each do |line|
        key, val = line.split(": ")
        hostnamectl[key.chomp.lstrip.tr(" ", "_").downcase] = val.chomp
      end
    end
  end
end
