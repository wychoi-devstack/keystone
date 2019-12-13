# Copyright 2019 SUSE LLC
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.

function configure_enforce_scope {
    iniset $KEYSTONE_CONF oslo_policy enforce_scope true
    iniset $KEYSTONE_CONF oslo_policy policy_file policy.yaml
    sudo systemctl restart devstack@keystone
    oslopolicy-policy-generator --namespace keystone > /etc/keystone/policy.yaml
}

function configure_protection_tests {
    iniset $TEMPEST_CONFIG identity-feature-enabled enforce_scope true
    iniset $TEMPEST_CONFIG auth admin_system true
    iniset $TEMPEST_CONFIG auth admin_project_name ''
}
