describe package ('nginx') do
	it { should be_installed }
end

describe service ('nginx') do 
	it { should be_running }
	it { should be_enabled }
end

describe port(80) do
	it { should be_listening }
end

describe package ('nodejs') do
  it { should be_installed }
  its('version') { should cmp > '6.10' }
end

describe npm ("pm2") do 
	it { should be_installed }
end
