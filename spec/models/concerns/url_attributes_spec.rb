require 'spec_helper'

shared_examples_for 'class with URL attributes' do |attrs_names|

  let(:class_name) { described_class.name.underscore.downcase.to_sym  }
  let(:url) { 'https://example.com' }
  let(:invalid_url) { 'example-invalid-url' }

  context 'validations' do
    context 'uniqueness' do
      attrs_names.each do |attr|
        describe "for :#{attr}" do
          before { create(class_name, attr => url)  }

          it 'is defined' do
            instance = build(class_name, attr => url)

            expect(instance.valid?).to be(false)
            expect(instance.errors.keys).to include(attr)
            expect(instance.errors.messages[attr][0]).to match(/already been taken/)
          end
        end
      end
    end

    context 'format' do
      attrs_names.each do |attr|
        describe "for :#{attr}" do
          it 'is defined' do
            instance = build(class_name, attr => invalid_url)

            expect(instance.valid?).to be(false)
            expect(instance.errors.keys).to include(attr)
            expect(instance.errors.messages[attr][0]).to match(/is invalid/)
          end
        end
      end
    end
  end
end
