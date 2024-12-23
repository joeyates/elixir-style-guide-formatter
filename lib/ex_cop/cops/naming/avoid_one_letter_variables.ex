defmodule ExCop.Cops.Naming.AvoidOneLetterVariables do
  @moduledoc """
  This module prints a warning if there are one-letter variable names.
  """
  def apply({forms, comments}) do
    forms =
      Macro.prewalk(forms, fn
        {name, context, nil} = node ->
          if one_letter?(name) do
            IO.warn("""
            one-letter variable name found
            #{context[:line]} | #{name}
            """)
          end

          node

        other ->
          other
      end)

    {forms, comments}
  end

  defp one_letter?(name) do
    name
    |> Atom.to_string()
    |> String.length()
    |> Kernel.==(1)
  end
end
