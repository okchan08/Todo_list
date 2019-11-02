module UsersHelper
  def task_status(task)
    case task.status
    when "untouched" then
      { message: "未完了", type: "primary" }
    when "inprogress" then
      { message: "処理中", type: "info" }
    when "done" then
      { message: "完了", type: "danger" }
    else
      ""
    end
  end
end
