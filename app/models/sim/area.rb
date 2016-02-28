module Sim
  class Area < Sim::Object

    # idle: all done, waiting for next loop
    # pending: should be simulated again and be queued soon
    # queued: ready for SimWorker to be picked up
    # performing: simulation is running by SimWorker
    enum status: { idle: 0, pending: 1, queued: 2, performing: 3 }

    scope :not_idle, -> { where.not(status: statuses[:idle]) }

    def self.set_idle_to_pending
      idle.update_all(status: statuses[:pending])
    end

  end
end