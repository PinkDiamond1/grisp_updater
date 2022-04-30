-module(grisp_updater_system).

%--- Includes ------------------------------------------------------------------

-include("grisp_updater.hrl").


%--- Types ---------------------------------------------------------------------

-type system_id() :: non_neg_integer().
-type system_state() :: trial | validated.

-export_type([system_id/0, system_state/0]).


%--- Behaviour Definition ------------------------------------------------------

-callback system_init(Opts :: map()) ->
    {ok, State :: term()} | {error, term()}.
-callback system_device(State :: term()) ->
    Device :: binary().
-callback system_get_active(State :: term()) ->
    {system_id() | removable, Validated :: boolean() | undefined}.
-callback system_prepare_update(State :: term(), SysId :: system_id()) ->
    {ok, State :: term()} | {error, term()}.
-callback system_prepare_target(State :: term(), SysId :: system_id(),
                                Target :: target_spec()) ->
    {ok, NewTarget :: target_spec()}.
-callback system_set_updated(State :: term(), SysId :: system_id()) ->
    {ok, State :: term()} | {error, term()}.
-callback system_validate(State :: term()) ->
    {ok, State :: term()} | {error, term()}.
-callback system_terminate(State :: term(), Reason :: term()) ->
    ok.

-optional_callbacks([system_prepare_target/3]).
