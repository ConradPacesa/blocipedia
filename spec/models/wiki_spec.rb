require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:wiki) { create(:wiki) }

  describe 'attributes' do
    it 'has title and body attributes' do
      expect(wiki).to have_attributes(title: wiki.title, body: wiki.body)
    end
  end
end
