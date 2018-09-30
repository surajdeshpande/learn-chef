# # encoding: utf-8

# Inspec test for recipe django::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

require 'spec_helper'

describe command('django-admin --version') do
    its(:stdout) { should match('/1.6.11/') }
end

