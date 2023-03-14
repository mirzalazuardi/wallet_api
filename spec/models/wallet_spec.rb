require 'rails_helper'

RSpec.describe Wallet, type: :model do
  subject { Wallet.create(ownable: user) }
  let(:user) { create :user }

  describe '#deposit' do
    context 'valid' do
      before do
        subject.deposit(10.0)
      end

      it { expect(subject.balance).to eq(10.0) }
    end

    context 'invalid' do
      it { expect { subject.deposit(-10) }.to raise_error('Invalid amount') }
    end
  end

  describe '#withdraw' do
    context 'valid' do
      before do
        subject.deposit(20)
        subject.withdraw(5)
      end

      it { expect(subject.balance).to eq(15) }
    end

    context 'invalid' do
      before do
        subject.deposit(20)
      end

      it { expect { subject.withdraw(21) }.to raise_error('Not enough fund') }
      it { expect { subject.withdraw(-21) }.to raise_error('Invalid amount') }
    end
  end
end
