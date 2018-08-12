class String
    def string_between_markers marker1, marker2
      self[/#{Regexp.escape(marker1)}(.*?)#{Regexp.escape(marker2)}/m, 1]
    end
  end