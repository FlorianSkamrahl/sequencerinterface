defmodule Sequencerinterface.SequencersTest do
  use Sequencerinterface.DataCase

  alias Sequencerinterface.Sequencers

  describe "sequencerpad" do
    alias Sequencerinterface.Sequencers.Sequencer

    import Sequencerinterface.SequencersFixtures

    @invalid_attrs %{color: nil, padid: nil, scale: nil, velocity: nil}

    test "list_sequencerpad/0 returns all sequencerpad" do
      sequencer = sequencer_fixture()
      assert Sequencers.list_sequencerpad() == [sequencer]
    end

    test "get_sequencer!/1 returns the sequencer with given id" do
      sequencer = sequencer_fixture()
      assert Sequencers.get_sequencer!(sequencer.id) == sequencer
    end

    test "create_sequencer/1 with valid data creates a sequencer" do
      valid_attrs = %{color: 42, padid: 42, scale: 42, velocity: 42}

      assert {:ok, %Sequencer{} = sequencer} = Sequencers.create_sequencer(valid_attrs)
      assert sequencer.color == 42
      assert sequencer.padid == 42
      assert sequencer.scale == 42
      assert sequencer.velocity == 42
    end

    test "create_sequencer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sequencers.create_sequencer(@invalid_attrs)
    end

    test "update_sequencer/2 with valid data updates the sequencer" do
      sequencer = sequencer_fixture()
      update_attrs = %{color: 43, padid: 43, scale: 43, velocity: 43}

      assert {:ok, %Sequencer{} = sequencer} = Sequencers.update_sequencer(sequencer, update_attrs)
      assert sequencer.color == 43
      assert sequencer.padid == 43
      assert sequencer.scale == 43
      assert sequencer.velocity == 43
    end

    test "update_sequencer/2 with invalid data returns error changeset" do
      sequencer = sequencer_fixture()
      assert {:error, %Ecto.Changeset{}} = Sequencers.update_sequencer(sequencer, @invalid_attrs)
      assert sequencer == Sequencers.get_sequencer!(sequencer.id)
    end

    test "delete_sequencer/1 deletes the sequencer" do
      sequencer = sequencer_fixture()
      assert {:ok, %Sequencer{}} = Sequencers.delete_sequencer(sequencer)
      assert_raise Ecto.NoResultsError, fn -> Sequencers.get_sequencer!(sequencer.id) end
    end

    test "change_sequencer/1 returns a sequencer changeset" do
      sequencer = sequencer_fixture()
      assert %Ecto.Changeset{} = Sequencers.change_sequencer(sequencer)
    end
  end
end
