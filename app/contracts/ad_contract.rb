class AdContract < ApplicationContract
  params do
    required(:title).filled(:string)
    required(:description).filled(:string)
    required(:city).filled(:string)
  end
end