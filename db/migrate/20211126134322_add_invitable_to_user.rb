class AddInvitableToUser < ActiveRecord::Migration[6.1]
  def change
    change_table :users do |t|
      t.datetime   :invitation_created_at
      t.datetime   :invitation_sent_at
      t.datetime   :invitation_accepted_at
    end
  end
end
