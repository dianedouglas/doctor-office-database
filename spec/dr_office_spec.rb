require 'rspec'
require 'pg'
require 'doctor'

DB = PG.connect({:dbname => 'doctors_office_tools'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM doctors *;")
  end
end

describe Doctor do

  it 'is initialized with a name and specialty' do
    test_doctor = Doctor.new('Dr. Mac', 1, 1)
    expect(test_doctor).to be_an_instance_of Doctor
  end

  it 'should return values for name and specialty' do
    test_doctor = Doctor.new('Dr. Mac', 1, 1)
    expect(test_doctor.name).to eq 'Dr. Mac'
    expect(test_doctor.specialty_id).to eq 1
  end

  it 'starts with no doctors' do
    expect(Doctor.all).to eq []
  end

  it 'saves the doctor object to the database' do
    test_doctor = Doctor.new('Dr. Mac', 1, 1)
    test_doctor.save
    expect(Doctor.all).to eq [test_doctor]
  end

  it 'returns true if the given doctor object has the same name as the current doctor object.' do
    test_doctor1 = Doctor.new('Dr. Mac', 1, 1)
    test_doctor2 = Doctor.new('Dr. Mac', 1, 1)
    expect(test_doctor1).to eq test_doctor2
  end

  it 'returns false if the given doctor object does not have the same name as the current doctor object.' do
    test_doctor1 = Doctor.new('Dr. Mac', 1, 1)
    test_doctor2 = Doctor.new('Dr. Mac', 2, 1)
    test_doctor1.should_not eq test_doctor2
  end


end

