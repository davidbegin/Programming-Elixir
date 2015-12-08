defmodule Issues.GithubIssues do
  @user_agent [ {"User-agent", "Elixir davidmichaelbe@gmail.com"} ]
  @github_url Application.get_env(:issues, :github_url)


  def process({user, project, _count}) do
    Issues.GithubIssues.fetch(user, project)
    |> decode_response
    |> convert_to_Lost_of_hashdicts
    |> sort_into_ascending_order
  end

  def fetch(user, project) do
    {_, response} = issues_url(user, project)
    |> HTTPoison.get(@user_agent)

    handle_response(response)
  end

  def decode_response({:ok, body}), do: body

  def decode_response({:error, error}) do
    {_, message} = List.keyfind(error, "message", 0)
    IO.puts "\e[31mError fetching from Github: #{message}\e[0m"
    System.halt(2)
  end

  def handle_response(%{status_code: 200, body: body}) do
    { :ok, :jsx.decode(body) }
  end

  def handle_response(%{status_code: _,   body: body}) do
    { :error, :jsx.decode(body) }
  end

  def sort_into_ascending_order(list_of_issues) do
    Enum.sort list_of_issues,
      fn l1, l2 -> l1["created_at"] <= l2["created_at"] end
  end

  def convert_to_Lost_of_hashdicts(list) do
    list
    |> Enum.map(&Enum.into(&1, HashDict.new))
  end

  def issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

end
