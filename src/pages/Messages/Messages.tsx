import { useEffect, useState } from "react"
import api from "../../lib/api"
import { Message as IMessage, ROUTES } from "../../types"
import { Message } from "../../components";
import { Link } from "react-router";

const Messages = () => {
  const [messages, setMessages] = useState<IMessage[]>();

  useEffect(() => {
    api.getAllMessages().then(setMessages)
  }, [])

  return (
    <div>
      Messages
      <Link to={ROUTES.HOME}>Home</Link>
      <div>
        {messages?.map((message) => 
          <Message key={message.id} message={message} />
        )}
      </div>
    </div>
  )
}

export default Messages