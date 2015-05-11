class Ptbudget < ActiveRecord::Base
  
  validates_presence_of :budget
  #Addsupplier.sum(:quantity, :conditions => ["supplier_id = ?", id])
  
  def budget_start
   Ptbudget.first.fiscalstart
  end
  
  def fiscal_end
    #fiscalstart + 1.year - 1.day
    main_fiscaldate=Date.new(fiscalstart.year, budget_start.month, budget_start.day)
    fiscalend=main_fiscaldate+1.year-1.day
  end
  
  def siblings_budget
    sibs=[]
    Ptbudget.all.group_by{|x|x.fiscal_end}.each do |fiscal_ending, ptbudgets|
      sibs = ptbudgets.map(&:id) if fiscal_ending==fiscal_end
    end
    sibs
  end
  
  def schedule_used_budget  #ptschedule of used budget
    rev_schedule_ids=[]
    if siblings_budget.count==1
      schedule_ids=Ptschedule.find(:all, :conditions =>['start >=? AND start <? AND budget_ok=?', fiscalstart, fiscalstart + 1.year, true]).map(&:id)
    else
      previous_fiscaldate=Date.new(fiscalstart.year, budget_start.month, budget_start.day)-1.year
      schedule_ids=Ptschedule.find(:all, :conditions => ["start >=? AND start <? AND budget_ok=?", previous_fiscaldate, fiscal_end, true]).map(&:id)
    end 
    schedule_ids.each do |schedule_id|
      total_participants=Ptdo.find(:all, :conditions => ['ptschedule_id=?', schedule_id]).count
      min_participants=Ptschedule.find(schedule_id).min_participants
      rev_schedule_ids << schedule_id if total_participants >= min_participants  
    end
    #schedule_ids
    rev_schedule_ids #schedule - attended by min participants!
  end
  
  def used_budget  #final amount
    if siblings_budget.count==1
      usedbudget=Ptschedule.sum(:final_price, :conditions =>['start >=? AND start <? AND budget_ok=? AND id IN(?)', fiscalstart, fiscalstart + 1.year, true, schedule_used_budget])
    else
      previous_fiscaldate=Date.new(fiscalstart.year, budget_start.month, budget_start.day)-1.year
      usedbudget=Ptschedule.sum(:final_price, :conditions => ["start >=? AND start <? AND budget_ok=? AND id IN(?)", previous_fiscaldate, fiscal_end, true, schedule_used_budget])
    end 
    usedbudget
  end
  
  def budget_balance   #current amount
    #budget-used_budget
    acc_budget-used_budget
  end
  
  def acc_budget   #accumulated as of current fiscalstart
    if fiscalstart.month==budget_start.month && fiscalstart.day==budget_start.day 
      accumulated_budget=budget
    else
      accumulated_budget=Ptbudget.sum(:budget, :conditions =>['id IN(?) and fiscalstart<=?', siblings_budget, fiscalstart])
    end
    accumulated_budget
  end
  
  def next_budget_date
    #Ptbudget.last.fiscalstart + 1.year
    last_fiscalstart=Ptbudget.find(:all, :order =>'fiscalstart ASC').last.fiscalstart
    last_fiscalend=Ptbudget.find(:all, :order =>'fiscalstart ASC').last.fiscal_end           #for all MAIN records, fiscal_end always same month & day
    if last_fiscalstart.month==budget_start.month && last_fiscalstart.day==budget_start.day 
      next_date=last_fiscalstart+1.year
    else
      next_date=Date.new(last_fiscalend.year, budget_start.month, budget_start.day)
    end
    next_date
  end 
  
end
