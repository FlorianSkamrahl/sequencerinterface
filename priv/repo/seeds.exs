# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Sequencerinterface.Repo.insert!(%Sequencerinterface.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


#for title <- ["Home Improvement", "Power Tools", "Gardening", "Books"] do
#  {:ok, _} = Hello.Catalog.create_category(%{title: title})
#end

#initialy add 64 sequencerpads

for current_index <- 0..63 do
  row = ceil((current_index - 7)/8)
  {:ok, _} = Sequencerinterface.Sequencers.create_sequencer(
    %{
      color: rem(current_index, 4),
      padid: current_index,
      scale: 1,
      velocity: 127,
      sequencergroup: 0,
      position: [row, rem(current_index, 8)]
    })

end
