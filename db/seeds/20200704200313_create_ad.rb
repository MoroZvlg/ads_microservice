Sequel.seed(:development) do
  def run
    Ad.create(title: 'test_title', description: 'test_description', city: 'SomeSity', user_id: 1)
  end
end
