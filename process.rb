#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require 'newrelic_rpm'
# start


::NewRelic::Agent.manual_start({:app_name => "mygreatapp"})


class Processor
  include ::NewRelic::Agent::Instrumentation::ControllerInstrumentation

  def pretend_to_work
    sleep 30
  end

  def self.pretend_to_work
    self.new.pretend_to_work
  end

  add_transaction_tracer :pretend_to_work, :category => :task
end

# workload


Processor.pretend_to_work()

# shutdown
::NewRelic::Agent.shutdown