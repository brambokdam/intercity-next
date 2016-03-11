class UpdateServerLoadJob < ActiveJob::Base
  queue_as :default

  def perform(server)
    return unless server.up?

    cpu = SshExecution.new(server).execute(command: "uptime | awk '{print $10}'  | tr -d '\n,'")
    memory = SshExecution.new(server).execute(command: "free | grep Mem | awk '{print $3/$2 * 100.0}' | tr -d '\n'")
    disk = SshExecution.new(server).execute(command: "df | awk '{print $6,$5;}' | grep '^/ ' |  tr -d '\n /%'")

    ServerLoadHistory.create(
      server: server,
      cpu: cpu,
      memory: memory,
      disk: disk
    )
  end
end
