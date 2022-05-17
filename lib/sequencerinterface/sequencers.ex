defmodule Sequencerinterface.Sequencers do
  @moduledoc """
  The Sequencers context.
  """

  import Ecto.Query, warn: false
  alias Sequencerinterface.Repo

  alias Sequencerinterface.Sequencers.Sequencer

  @doc """
  Returns the list of sequencerpad.

  ## Examples

      iex> list_sequencerpad()
      [%Sequencer{}, ...]

  """
  def list_sequencerpad do
    #Repo.all(Sequencer)
    Repo.all(from s in Sequencer, order_by: [asc: s.padid])
  end

  @doc """
  Gets a single sequencer.

  Raises `Ecto.NoResultsError` if the Sequencer does not exist.

  ## Examples

      iex> get_sequencer!(123)
      %Sequencer{}

      iex> get_sequencer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_sequencer!(id), do: Repo.get!(Sequencer, id)

  @doc """
  Creates a sequencer.

  ## Examples

      iex> create_sequencer(%{field: value})
      {:ok, %Sequencer{}}

      iex> create_sequencer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_sequencer(attrs \\ %{}) do
    %Sequencer{}
    |> Sequencer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a sequencer.

  ## Examples

      iex> update_sequencer(sequencer, %{field: new_value})
      {:ok, %Sequencer{}}

      iex> update_sequencer(sequencer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_sequencer(%Sequencer{} = sequencer, attrs) do
    sequencer
    |> Sequencer.changeset(attrs)
    |> Repo.update()
  end

  def toggle_color(padid, color) do
    {1, [sequencer]} =
      from(s in Sequencer, where: s.padid == ^padid, select: s)
      |> Repo.update_all(set: [color: color])

    SequencerinterfaceWeb.Endpoint.broadcast!("sequencer:lobby", "updated_sequencerpad", %{color: sequencer.color, padid: sequencer.padid, position: sequencer.position})
    broadcast({:ok, sequencer}, :updated_sequencerpad)

  end

  def toggle_feedback_color(padid, color) do
    {1, [sequencer]} =
      from(s in Sequencer, where: s.padid == ^padid, select: s)
      |> Repo.update_all(set: [feedback_color: color])
    broadcast({:ok, sequencer}, :updated_sequencerpad)
  end

  def clear_sequencerpad_group(group) do

    {_, sequencer} =
      from(s in Sequencer, where: s.sequencergroup == ^group, select: s)
      |> Repo.update_all(set: [color: -1, feedback_color: -1])

    broadcast({:ok, sequencer}, :clear_sequencerpad)

  end

  @doc """
  Deletes a sequencer.

  ## Examples

      iex> delete_sequencer(sequencer)
      {:ok, %Sequencer{}}

      iex> delete_sequencer(sequencer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_sequencer(%Sequencer{} = sequencer) do
    Repo.delete(sequencer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking sequencer changes.

  ## Examples

      iex> change_sequencer(sequencer)
      %Ecto.Changeset{data: %Sequencer{}}

  """
  def change_sequencer(%Sequencer{} = sequencer, attrs \\ %{}) do
    Sequencer.changeset(sequencer, attrs)
  end

  def subscribe() do
    Phoenix.PubSub.subscribe(Sequencerinterface.PubSub, "sequencers")
  end

  defp broadcast({:error, _reason} = error, _event), do: error
  defp broadcast({:ok, sequencerpad}, event) do
    Phoenix.PubSub.broadcast(Sequencerinterface.PubSub, "sequencers", {event, sequencerpad})
    {:ok, sequencerpad}
  end
end
