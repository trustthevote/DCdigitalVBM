require 'tempfile'
class Tempfile
  def size
    if @tmpfile
      @tmpfile.fsync
      @tmpfile.flush
      @tmpfile.stat.size
    else
      0
    end
  end
end