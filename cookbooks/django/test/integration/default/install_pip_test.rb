# # encoding: utf-8

# Inspec test for recipe django::install_pip

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe command('django-admin --version') do
    its(:stdout) { should match(1.7.5) }
end