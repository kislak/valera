require 'spec_helper'
require 'active_support/core_ext/string/inflections'
require 'fileutils'

RSpec.describe 'TestSuite' do
  Dir['{app,lib}/**/*.rb'].each do |file|
    next if file.match?(%r{app\/admin\/})

    context file do
      subject { file }

      let(:testfile) do
        file.sub('app', 'spec').sub('lib', 'spec/lib').sub('.rb', '_spec.rb')
      end

      it 'should have tests' do
        expect(File.exist?(testfile)).to be_truthy
        class_name = File.basename(file, '.rb').classify
        File.open(testfile, encoding: 'utf-8') do |f|
          expect(f.read).to match(class_name)
        end
      end
    end
  end
end


