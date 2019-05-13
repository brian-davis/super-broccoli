require 'rails_helper'

RSpec.describe Shortlink, type: :model do
  describe 'validations' do
    describe 'source' do
      it { should validate_presence_of(:source) }

      describe 'format' do
        context 'valid' do
          it 'accepts valid shortlinks' do
            expect(FactoryBot.build(:shortlink)).to be_valid
          end
        end

        context 'invalid' do
          it 'rejects invalid shortlinks' do
            expect(FactoryBot.build(:shortlink, { source: 'gttp://ww.wrong' })).not_to be_valid
          end

          it 'avoids URI class bug' do
            expect(FactoryBot.build(:shortlink, { source: 'https://' })).not_to be_valid
          end
        end
      end
    end

    describe 'slug' do
      it 'will set a unique value before commit' do
        shortlink = FactoryBot.build(:shortlink)
        expect(shortlink.slug).to be_nil
        shortlink.save
        shortlink.reload
        expect(shortlink.slug).to match(/[a-zA-Z0-9\-_]{6}/)
      end
    end
  end
end
