defmodule ToyUploadS3.PageController do
  use ToyUploadS3.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
