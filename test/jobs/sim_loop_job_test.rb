require 'test_helper'

class SimLoopJobTest < ActiveJob::TestCase
  fixtures 'sim/areas'

  def setup
    @job = SimLoopJob.new
  end

  test 'set_idle_to_pending' do
    Sim::Area.update_all(status: Sim::Area.statuses[:idle])
    idles = Sim::Area.idle.count

    @job.stub :sim_next_objects, nil do
      assert_difference('Sim::Area.pending.count', idles) do
        @job.perform
      end
    end
  end

  def test_queue_up_pending
    pending = Sim::Area.pending.count
    assert_difference('Sim::Area.queued.count', pending) do
      @job.perform
    end
  end

end
