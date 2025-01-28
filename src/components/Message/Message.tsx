import { type Message as IMessage } from '../../types';
import s from './Message.module.scss';

interface MessageProps {
  message: IMessage;
}

const Message: React.FC<MessageProps> = ({ message }) => {
  return (
    <div className={s.message}>
      <h3 className={s.subject}>{message.subject}</h3>
      <p className={s.content}>{message.content}</p>
      <p className={s.timestamp}>Created at: {new Date(message.date_created).toLocaleString()}</p>
    </div>
  );
};

export default Message;
