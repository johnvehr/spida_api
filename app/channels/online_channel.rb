class OnlineChannel < ApplicationCable::Channel
  def subscribed
    stream_from "online:#{current_user.id}"
    account = Account.find(params[:account])
    ids = ActionCable.server.pubsub.redis_connection_for_subscriptions.smembers "online_#{account.id}"
    if ids.include? current_user.id
      puts 'great'
    else
=begin
the other option
is to send back current user and store in online users
on redux the loop through each time check if any is different from the store
then you would call notify but this will not be true real time i dont think
=end
      ActionCable.server.pubsub.redis_connection_for_subscriptions.sadd "online_#{account.id}", current_user.id
      account.users.each do |user|
      broadcast_to user.id, {user: current_user, status: "online"}
    end

    # stream_from "some_channel

  end
end

  def unsubscribed
    account = Account.find(params[:account])
    ActionCable.server.pubsub.redis_connection_for_subscriptions.srem "online_#{account.id}", current_user.id

    # Any cleanup needed when channel is unsubscribed
    broadcast_to "users", {user: current_user, status: "offline"}

  end
end
