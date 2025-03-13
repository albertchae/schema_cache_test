class BarsController < ApplicationController
  def index
    @foos = Foo.all
    @bars = Bar.all
  end
end