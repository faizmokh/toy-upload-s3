defmodule ToyUploadS3.Upload do
  use ToyUploadS3.Web, :model

  schema "uploads" do
    field :image_url, :string
    
    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:image_url])
    |> validate_required([:image_url])
  end
end
    