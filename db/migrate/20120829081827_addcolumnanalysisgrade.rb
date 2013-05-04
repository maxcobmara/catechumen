class Addcolumnanalysisgrade < ActiveRecord::Migration
  def self.up
    #addcolumn full mark
       add_column :analysis_grades, :fm_1, :integer
       add_column :analysis_grades, :fm_2, :integer
       add_column :analysis_grades, :fm_3, :integer
       add_column :analysis_grades, :fm_4, :integer
       add_column :analysis_grades, :fm_5, :integer
       add_column :analysis_grades, :fm_6, :integer
       add_column :analysis_grades, :fm_7, :integer
       add_column :analysis_grades, :fm_8, :integer
       add_column :analysis_grades, :fm_9, :integer
       add_column :analysis_grades, :fm_10, :integer
       add_column :analysis_grades, :fm_11, :integer
       add_column :analysis_grades, :fm_12, :integer

       add_column :analysis_grades, :fm_13, :integer
       add_column :analysis_grades, :fm_14, :integer
       add_column :analysis_grades, :fm_15, :integer
       add_column :analysis_grades, :fm_16, :integer
       add_column :analysis_grades, :fm_17, :integer
       add_column :analysis_grades, :fm_18, :integer
       add_column :analysis_grades, :fm_19, :integer
       add_column :analysis_grades, :fm_20, :integer
       add_column :analysis_grades, :fm_21, :integer
       add_column :analysis_grades, :fm_22, :integer
       add_column :analysis_grades, :fm_23, :integer
       add_column :analysis_grades, :fm_24, :integer

       add_column :analysis_grades, :fm_25, :integer
       add_column :analysis_grades, :fm_26, :integer
       add_column :analysis_grades, :fm_27, :integer
       add_column :analysis_grades, :fm_28, :integer
       add_column :analysis_grades, :fm_29, :integer
       add_column :analysis_grades, :fm_30, :integer
       add_column :analysis_grades, :fm_31, :integer
       add_column :analysis_grades, :fm_32, :integer
       add_column :analysis_grades, :fm_33, :integer
       add_column :analysis_grades, :fm_34, :integer
       add_column :analysis_grades, :fm_35, :integer
       add_column :analysis_grades, :fm_36, :integer

       add_column :analysis_grades, :fm_37, :integer
       add_column :analysis_grades, :fm_38, :integer
       add_column :analysis_grades, :fm_39, :integer
       add_column :analysis_grades, :fm_40, :integer
       add_column :analysis_grades, :fm_41, :integer
       add_column :analysis_grades, :fm_42, :integer
       add_column :analysis_grades, :fm_43, :integer
       add_column :analysis_grades, :fm_44, :integer
       add_column :analysis_grades, :fm_45, :integer
       add_column :analysis_grades, :fm_46, :integer
       add_column :analysis_grades, :fm_47, :integer
       add_column :analysis_grades, :fm_48, :integer
       add_column :analysis_grades, :fm_49, :integer
       add_column :analysis_grades, :fm_50, :integer
  end

  def self.down
    #addcolumn full mark
       remove_column :analysis_grades, :fm_1
       remove_column :analysis_grades, :fm_2
       remove_column :analysis_grades, :fm_3
       remove_column :analysis_grades, :fm_4
       remove_column :analysis_grades, :fm_5
       remove_column :analysis_grades, :fm_6
       remove_column :analysis_grades, :fm_7
       remove_column :analysis_grades, :fm_8
       remove_column :analysis_grades, :fm_9
       remove_column :analysis_grades, :fm_10
       remove_column :analysis_grades, :fm_11
       remove_column :analysis_grades, :fm_12

       remove_column :analysis_grades, :fm_13
       remove_column :analysis_grades, :fm_14
       remove_column :analysis_grades, :fm_15
       remove_column :analysis_grades, :fm_16
       remove_column :analysis_grades, :fm_17
       remove_column :analysis_grades, :fm_18
       remove_column :analysis_grades, :fm_19
       remove_column :analysis_grades, :fm_20
       remove_column :analysis_grades, :fm_21
       remove_column :analysis_grades, :fm_22
       remove_column :analysis_grades, :fm_23
       remove_column :analysis_grades, :fm_24

       remove_column :analysis_grades, :fm_25
       remove_column :analysis_grades, :fm_26
       remove_column :analysis_grades, :fm_27
       remove_column :analysis_grades, :fm_28
       remove_column :analysis_grades, :fm_29
       remove_column :analysis_grades, :fm_30
       remove_column :analysis_grades, :fm_31
       remove_column :analysis_grades, :fm_32
       remove_column :analysis_grades, :fm_33
       remove_column :analysis_grades, :fm_34
       remove_column :analysis_grades, :fm_35
       remove_column :analysis_grades, :fm_36

       remove_column :analysis_grades, :fm_37
       remove_column :analysis_grades, :fm_38
       remove_column :analysis_grades, :fm_39
       remove_column :analysis_grades, :fm_40
       remove_column :analysis_grades, :fm_41
       remove_column :analysis_grades, :fm_42
       remove_column :analysis_grades, :fm_43
       remove_column :analysis_grades, :fm_44
       remove_column :analysis_grades, :fm_45
       remove_column :analysis_grades, :fm_46
       remove_column :analysis_grades, :fm_47
       remove_column :analysis_grades, :fm_48
       remove_column :analysis_grades, :fm_49
       remove_column :analysis_grades, :fm_50


    
  end
end
