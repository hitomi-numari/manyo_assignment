FactoryBot.define do
  factory :label do
    name { "Factoryで作ったデフォルトのラベル１" }
  end
  factory :second_label, class: Label do
    name { "Factoryで作ったデフォルトのラベル２" }
  end
  factory :third_label, class: Label do
    name { "Factoryで作ったデフォルトのラベル３" }
  end
end
