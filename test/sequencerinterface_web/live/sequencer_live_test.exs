defmodule SequencerinterfaceWeb.SequencerLiveTest do
  use SequencerinterfaceWeb.ConnCase

  import Phoenix.LiveViewTest
  import Sequencerinterface.SequencersFixtures

  @create_attrs %{color: 42, padid: 42, scale: 42, velocity: 42}
  @update_attrs %{color: 43, padid: 43, scale: 43, velocity: 43}
  @invalid_attrs %{color: nil, padid: nil, scale: nil, velocity: nil}

  defp create_sequencer(_) do
    sequencer = sequencer_fixture()
    %{sequencer: sequencer}
  end

  describe "Index" do
    setup [:create_sequencer]

    test "lists all sequencerpad", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, Routes.sequencer_index_path(conn, :index))

      assert html =~ "Listing Sequencerpad"
    end

    test "saves new sequencer", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.sequencer_index_path(conn, :index))

      assert index_live |> element("a", "New Sequencer") |> render_click() =~
               "New Sequencer"

      assert_patch(index_live, Routes.sequencer_index_path(conn, :new))

      assert index_live
             |> form("#sequencer-form", sequencer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#sequencer-form", sequencer: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.sequencer_index_path(conn, :index))

      assert html =~ "Sequencer created successfully"
    end

    test "updates sequencer in listing", %{conn: conn, sequencer: sequencer} do
      {:ok, index_live, _html} = live(conn, Routes.sequencer_index_path(conn, :index))

      assert index_live |> element("#sequencer-#{sequencer.id} a", "Edit") |> render_click() =~
               "Edit Sequencer"

      assert_patch(index_live, Routes.sequencer_index_path(conn, :edit, sequencer))

      assert index_live
             |> form("#sequencer-form", sequencer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#sequencer-form", sequencer: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.sequencer_index_path(conn, :index))

      assert html =~ "Sequencer updated successfully"
    end

    test "deletes sequencer in listing", %{conn: conn, sequencer: sequencer} do
      {:ok, index_live, _html} = live(conn, Routes.sequencer_index_path(conn, :index))

      assert index_live |> element("#sequencer-#{sequencer.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#sequencer-#{sequencer.id}")
    end
  end

  describe "Show" do
    setup [:create_sequencer]

    test "displays sequencer", %{conn: conn, sequencer: sequencer} do
      {:ok, _show_live, html} = live(conn, Routes.sequencer_show_path(conn, :show, sequencer))

      assert html =~ "Show Sequencer"
    end

    test "updates sequencer within modal", %{conn: conn, sequencer: sequencer} do
      {:ok, show_live, _html} = live(conn, Routes.sequencer_show_path(conn, :show, sequencer))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Sequencer"

      assert_patch(show_live, Routes.sequencer_show_path(conn, :edit, sequencer))

      assert show_live
             |> form("#sequencer-form", sequencer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#sequencer-form", sequencer: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.sequencer_show_path(conn, :show, sequencer))

      assert html =~ "Sequencer updated successfully"
    end
  end
end
