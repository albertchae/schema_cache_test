class FoosController < ApplicationController
  def index
    @foos = Foo.all
  end
end