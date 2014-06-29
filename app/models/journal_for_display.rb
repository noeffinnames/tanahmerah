class JournalForDisplay
  def initialize(expense_id, owed_user_id, owing_user_id, amount)
    @expense_id     = expense_id
    @owed_user_id   = owed_user_id
    @owing_user_id  = owing_user_id
    @amount         = amount
  end
  attr_reader :expense_id, :owed_user_id, :owing_user_id, :amount

  def owed_user_name
    aUser = User.find(@owed_user_id)
    if aUser == nil then
      return "Unknown"
    end
    aUser.name
  end

  def owing_user_name
    aUser = User.find(@owing_user_id)
    if aUser == nil then
      return "Unknown"
    end
    aUser.name
  end
end
