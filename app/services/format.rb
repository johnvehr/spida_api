module Format
=begin
  def format_my_data(seed,data)
    new_data = {}
    new_data['name'] = seed.seed_title #new_data = {}
    new_data['children'] = data
    new_data['children'].each do |plan|
      if plan.children.count > 0
        plan['children'] = plan.children
        if plan.children.count > 1
          plan.children.each do |plan_sub|
            plan_sub['children'] = plan_sub.children
          end
        end
      end
    end
    new_data
  end
=end
  def format_my_data(project,data)
    new_data = {}
    new_data['name'] = project.project_title #new_data = {}
    new_data['children'] = data.arrange_serializable
    new_data
  end

      #data.each do |d|
      #  if d.children.count > 0
      #    new_data['children'] = [d.children]
      #  end
      #
      #end
      #puts new_data
    #end

end
