defmodule Mix.Tasks.Checkwriter do
    use Mix.Task
  
    @shortdoc "Simply runs the Hello.say/0 command."
    def run(t) do
      Checkwriter.main(to_string(t)) # calling our Hello.say() function from earlier
    end
  end