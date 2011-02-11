class CreateExamquestions < ActiveRecord::Migration
  def self.up
    create_table :examquestions do |t|
           t.integer    :curriculum_id
           t.string     :questiontype
           t.string     :question
           t.text       :answer
           t.decimal    :marks
           t.string     :category
           t.string     :qkeyword
           t.string     :qstatus
           t.integer    :creator_id
           t.date       :createdt
           t.string     :status
           t.text       :statusremark
           t.integer    :editor_id
           t.date       :editdt
           t.integer    :approver_id
           t.date       :approvedt
           t.boolean    :bplreserve
           t.boolean    :bplsent
           t.date       :bplsentdt

      t.timestamps
    end
  end

  def self.down
    drop_table :examquestions
  end
end
