module Wapiti
  describe Dataset do
    let(:ch) { File.read(fixture('chtest.txt')).strip }
    let(:ds) { Dataset.open fixture('chtest.txt'), tagged: true }

    describe '.open' do
      let(:xml) { Dataset.open fixture('chtrain.xml') }
      let(:txt) { Dataset.open fixture('chtrain.txt'), tagged: true }

      it 'opens xml files' do
        expect(xml.size).to eq(823)
      end
      it 'opens txt files' do
        expect(txt).to eq(xml)
      end
    end

    describe '#to_a' do
      it 'returns an array of token string arrays' do
        expect(ds.to_a.length).to eq(77)
        expect(ds.to_a[0].length).to eq(37)
        expect(ds.to_a[0][1]).to eq('in IN B-PP')
      end
    end

    describe '#to_s' do
      it 'returns just the tokens by default' do
        expect(ds.to_s).to eq(ch)
      end
    end

    describe '#to_yml' do
      let(:h) { ds.to_yml }

      it 'returns an array of segment hashes' do
        expect(h.length).to eq(77)
        expect(h[0].keys).to eq(%w{B-NP B-PP I-NP B-VP I-VP B-SBAR O B-ADJP})
        expect(h[0]['I-NP']).to eq([
          'pound',
          'sharp dive',
          'figures',
          'substantial improvement',
          'and August',
          'near-record deficits'
        ])
      end
    end

    describe '#to_xml' do
      it 'returns a <dataset>' do
        expect(ds.to_xml(indent: 2).to_s).to start_with(<<~EOS)
          <?xml version="1.0" encoding="UTF-8"?>
          <dataset>
            <sequence>
              <B-NP>Confidence</B-NP>
        EOS
      end
    end
  end
end