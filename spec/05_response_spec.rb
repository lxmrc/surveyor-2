require 'spec_helper'

RSpec.describe Surveyor::Response do
  subject { described_class.new(email: "respondent@example.com") }

  it 'has an email' do
    expect(subject.email).to eq("respondent@example.com")
  end
end
