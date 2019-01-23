require './lib/atm.rb'
require 'date'

describe ATM do
    let(:account) { instance_double('Account') }

    before do
        allow(account).to receive(:balance).and_return(100)
        allow(account).to receive(:balance=)
    end

    it'has $1000 on init' do
        expect(subject.funds).to eq 1000
    end

    it'reduce amount on withdraw' do
        subject.withdraw(50, account)
        expect(subject.funds).to eq 950
    end

    it'allow withdrawal if account has enough balance' do
        expected_output = {status: true, message: 'success', date: Date.today, amount: 45}
        expect(subject.withdraw(45,account)).to eq expected_output
    end

    it'reject withdrawal if account has insufficient funds' do
        expected_output = {status: false, message: 'insufficient funds', date: Date.today}
        expect(subject.withdraw(105, account)).to eq expected_output
    end
    
    it 'reject withdraw if ATM has insufficient funds' do
        subject.funds = 50
        expected_output =  { status: false, message: 'insufficient funds in ATM', date: Date.today }
        expect(subject.withdraw(100, account)).to eq expected_output
    end
    
    
   
end
