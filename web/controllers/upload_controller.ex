defmodule ToyUploadS3.UploadController do
    use ToyUploadS3.Web, :controller
      
    alias ToyUploadS3.Upload

    def index(conn, _params) do
      render conn, "index.html"
    end
  
    def new(conn, _params) do
      changeset = Upload.changeset(%Upload{})
      render conn, "new.html", changeset: changeset
    end

    def create(conn, %{"upload" => %{"image" => image_params} = upload_params}) do
      file_uuid = UUID.uuid4(:hex)
      image_filename = image_params.filename
      unique_filename = "#{file_uuid}-#{image_filename}"
      {:ok, image_binary} = File.read(image_params.path)
      bucket_name = System.get_env("BUCKET_NAME")

      image = ExAws.S3.put_object(bucket_name, unique_filename, image_binary) 
      |> ExAws.request!
            |> put_flash(:info, "Successful image upload!")
          |> redirect(to: upload_path(conn, :index))


      IO.inspect image

      updated_params = upload_params
      |> Map.update(image, image_params, fn _value -> 
        "https://#{bucket_name}.s3.amazonaws.com/#{bucket_name}/#{unique_filename}" end)

      IO.inspect updated_params
    
      changeset = Upload.changeset(%Upload{}, updated_params)

      case Repo.insert(changeset) do
        {:ok, upload} ->
          conn
        {:error, changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    end


  end
  