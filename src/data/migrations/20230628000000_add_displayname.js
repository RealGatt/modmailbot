exports.up = async function (knex, Promise) {
  await knex.schema.table("thread_messages", (table) => {
    table.string("display_name").nullable().defaultTo(null);
  });
};

exports.down = async function (knex, Promise) {
  await knex.schema.table("thread_messages", (table) => {
    table.dropColumn("display_name");
  });
};
