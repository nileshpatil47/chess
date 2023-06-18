require 'spec_helper'
require 'chess.rb'

describe Chess do
  let(:x) { 0 }
  let(:y) { 1 }
  let(:direction) { 'NORTH' }
  let(:colour) { 'WHITE' }
  let(:object) { Chess.new(x, y, direction, colour) }

  describe '#constant' do
    it 'created constants that are expected' do
      expect(Chess::DIRECTION).to eql(["WEST", "NORTH", "EAST", "SOUTH"])
      expect(Chess::X).to eql(0)
      expect(Chess::Y).to eql(1)
      expect(Chess::VALID_FIRST_MOVE).to eql([0, 1, 2])
    end
  end

  describe '#initialize' do
    context 'initialize with any data' do
      it "should return object values passed" do
        expect(object.colour).to eq colour
        expect(object.direction).to eq Chess::DIRECTION.index(direction)
        expect(object.current_position).to eq [nil, nil]
        expect(object.next_position).to eq [x, y]
        expect(object.placed).to be_nil
      end
    end
  end

  describe '#place' do
    let(:colour) { 'Black' }

    context 'initialize with valid data' do
      before { object.place }

      it "should return object values passed" do
        expect(object.colour).to eq colour
        expect(object.direction).to eq Chess::DIRECTION.index(direction)
        expect(object.current_position).to eq [x, y]
        expect(object.next_position).to eq [x, y]
        expect(object.placed).to be_truthy
      end
    end

    context 'initialize with invalid data' do
      let(:y) { 5 }

      before { object.place }

      it "should not return object values passed" do
        expect(object.colour).to eq nil
        expect(object.direction).to eq nil
        expect(object.current_position).to eq [nil, nil]
        expect(object.next_position).to eq [nil, nil]
        expect(object.placed).to be_falsey
      end
    end
  end

  describe '#left' do
    let(:x) { 3 }
    let(:y) { 1 }
  
    context 'When direction is SOUTH' do
      let(:direction) { 'SOUTH' }
      before { object.place }

      it "should change direction from SOUTH to EAST" do
        expect{ object.left }.to change{ object.direction }.from(3).to(2)
      end
    end

    context 'When direction is WEST' do
      let(:direction) { 'WEST' }

      before { object.place }

      it "should change direction from WEST to SOUTH" do
        expect{ object.left }.to change{ object.direction }.from(0).to(3)
      end
    end
  end

  describe '#right' do
    let(:x) { 3 }
    let(:y) { 1 }
  
    context 'When direction is SOUTH' do
      let(:direction) { 'SOUTH' }
      before { object.place }

      it "should change direction from SOUTH to WEST" do
        expect{ object.right }.to change{ object.direction }.from(3).to(0)
      end
    end

    context 'When direction is WEST' do
      let(:direction) { 'WEST' }

      before { object.place }

      it "should change direction from WEST to NORTH" do
        expect{ object.right }.to change{ object.direction }.from(0).to(1)
      end
    end
  end

  describe '#move' do
    let(:x) { 3 }
    let(:y) { 1 }
  
    context 'when direction is NORTH' do
      let(:direction) { 'NORTH' }
      before { object.place }

      it 'When pawn moved to forword' do
        expect{ object.move }.to change{ object.current_position }.from([3, 1]).to([3, 2])
      end
    end

    context 'when direction is EAST' do
      let(:direction) { 'EAST' }
      before { object.place }

      it 'When pawn moved to forword' do
        expect{ object.move }.to change{ object.current_position }.from([3, 1]).to([4, 1])
      end
    end

    context 'when direction is SOUTH' do
      let(:direction) { 'SOUTH' }
      before { object.place }

      it 'When pawn moved to forword' do
        expect{ object.move }.to change{ object.current_position }.from([3, 1]).to([3, 0])
      end
    end

    context 'when direction is WEST' do
      let(:direction) { 'WEST' }
      before { object.place }

      it 'When pawn moved to forword' do
        expect{ object.move }.to change{ object.current_position }.from([3, 1]).to([2, 1])
      end
    end

    context 'when direction is WEST' do
      let(:x) { 0 }
      let(:y) { 1 }
      let(:direction) { 'WEST' }
      before do
        object.place
        object.move
      end

      it 'pawn did not move to forword due to limitation of chess board' do
        expect(object.current_position).to eq [0, 1]
      end
    end

    context 'when direction is SOUTH' do
      let(:x) { 0 }
      let(:y) { 0 }
      let(:direction) { 'SOUTH' }
      before do
        object.place
        object.move
      end

      it 'pawn did not move to forword due to limitation of chess board' do
        expect(object.current_position).to eq [0, 0]
      end
    end

    context 'when direction is EAST' do
      let(:x) { 7 }
      let(:y) { 0 }
      let(:direction) { 'EAST' }
      before do
        object.place
        object.move
      end

      it 'pawn did not move to forword due to limitation of chess board' do
        expect(object.current_position).to eq [7, 0]
      end
    end
  end

  describe '#report' do
    context 'when placed is successful' do
      it 'current position updates' do
        expect{ object.place }.to change{ object.current_position }.from([nil, nil]).to([0, 1])
        expect(object.placed).to eq true
      end
    end

    context 'when placed is not successful' do
      let(:x) { 4 }
      let(:y) { 4 }

      before { object.place }
      it 'current position will not update' do
        expect(object.current_position).to eq [nil, nil]
        expect(object.placed).to eq false
      end
    end
  end
end
