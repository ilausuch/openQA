package Schema::Result::JobStates;
use base qw/DBIx::Class::Core/;

__PACKAGE__->table('job_states');
__PACKAGE__->add_columns(
    id => {
        data_type => 'integer',
        is_auto_increment => 1,
    },
    name => {
        data_type => 'text',
    }
   );

__PACKAGE__->set_primary_key('id');
__PACKAGE__->has_many(jobs => 'Schema::Result::Jobs', 'state_id');

1;
