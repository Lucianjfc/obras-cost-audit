import PropTypes from 'prop-types';
import Form from './form';

export default function EditRelatorioObra({ history, match }) {
  return <Form id={match.params.id} history={history} action="edit" />;
}

EditRelatorioObra.propTypes = {
  history: PropTypes.any,
  match: PropTypes.any,
};
