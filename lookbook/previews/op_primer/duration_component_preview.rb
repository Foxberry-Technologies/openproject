module OpPrimer
  # @logical_path OpenProject/Primer
  class DurationComponentPreview < Lookbook::Preview
    # @param duration number
    # @param type select { choices: [seconds, minutes, hours, days, weeks, months, years] }
    # @param separator text
    # @param abbreviated toggle
    def default(duration: 1234, type: :minutes, separator: ', ', abbreviated: false)
      render OpPrimer::DurationComponent.new(duration, type, separator:, abbreviated:)
    end

    def system_arguments
      render OpPrimer::DurationComponent.new(3625, :seconds, color: :subtle)
    end

    def iso8601
      render OpPrimer::DurationComponent.new('P3DT12H5M', :seconds, color: :subtle)
    end
  end
end
