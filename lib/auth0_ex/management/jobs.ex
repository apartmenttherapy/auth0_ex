defmodule Auth0Ex.Management.Jobs do
  @moduledoc """
  Create and inspect Jobs such as User Import and User Export
  """
  use Auth0Ex.Api, for: :mgmt
  @path "jobs"

  @doc """
  Gets a specific job status with a given job id

      iex> Auth0Ex.Management.Jobs.get("something")
  """
  def get(job_id) when is_binary(job_id) do
    do_get("#{@path}/#{job_id}", %{})
  end

  @doc """
  Gets the errors for a completed job by job id

      iex> Auth0Ex.Management.Jobs.get_errors("something")
  """
  def get_errors(job_id) when is_binary(job_id) do
    do_get("#{@path}/#{job_id}/errors", %{})
  end

  @doc """
  Gets the results for a completed job by job id

      iex> Auth0Ex.Management.Jobs.get_results("something")
  """
  def get_results(job_id) when is_binary(job_id) do
    do_get("#{@path}/#{job_id}/results", %{})
  end

  @doc """
  Send an email to the specified user that asks them to click a link to verify
  their email address.

  If the id of the client is not provided the global one will be used

      iex> Auth0Ex.Management.Jobs.verification_email("auth0|some_user_id")
      iex> Auth0Ex.Management.Jobs.verification_email("auth0|some_user_id", "someclient")
  """
  def verification_email(user_id) when is_binary(user_id) do
    do_post("#{@path}/verification-email", %{user_id: user_id})
  end
  def verification_email(user_id, client_id) when is_binary(user_id) and is_binary(client_id) do
    do_post("#{@path}/verification-email", %{user_id: user_id, client_id: client_id})
  end

  @doc """
  Kick off a job of importing Users.  Doesn't support all the options yet

      iex> Auth0Ex.Management.Jobs.users_imports("/path/to/filename.json", "con_something")
      iex> Auth0Ex.Management.Jobs.users_imports("/path/to/filename.json", "con_something", "true")
  """
  def users_imports(file, connection_id, upsert \\ "false", params \\ %{}) do
    do_upload("#{@path}/users-imports", params, {:multipart, [{:file, file, {"form-data", [ name: "users", filename: Path.basename(file)] }, []}, {"connection_id", connection_id}, {"upsert", upsert}]})
  end
end
