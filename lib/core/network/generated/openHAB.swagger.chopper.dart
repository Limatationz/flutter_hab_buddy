// dart format width=80
//Generated code

part of 'openHAB.swagger.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$OpenHAB extends OpenHAB {
  _$OpenHAB([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = OpenHAB;

  @override
  Future<Response<List<ModuleTypeDTO>>> _moduleTypesGet({
    String? acceptLanguage,
    String? tags,
    String? type,
  }) {
    final Uri $url = Uri.parse('/module-types');
    final Map<String, dynamic> $params = <String, dynamic>{
      'tags': tags,
      'type': type,
    };
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<List<ModuleTypeDTO>, ModuleTypeDTO>($request);
  }

  @override
  Future<Response<ModuleTypeDTO>> _moduleTypesModuleTypeUIDGet({
    String? acceptLanguage,
    required String? moduleTypeUID,
  }) {
    final Uri $url = Uri.parse('/module-types/${moduleTypeUID}');
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<ModuleTypeDTO, ModuleTypeDTO>($request);
  }

  @override
  Future<Response<List<EnrichedRuleDTO>>> _rulesGet({
    String? prefix,
    List<String>? tags,
    bool? summary,
    bool? staticDataOnly,
  }) {
    final Uri $url = Uri.parse('/rules');
    final Map<String, dynamic> $params = <String, dynamic>{
      'prefix': prefix,
      'tags': tags,
      'summary': summary,
      'staticDataOnly': staticDataOnly,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<EnrichedRuleDTO>, EnrichedRuleDTO>($request);
  }

  @override
  Future<Response<dynamic>> _rulesPost({required RuleDTO? body}) {
    final Uri $url = Uri.parse('/rules');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _rulesRuleUIDEnablePost({
    required String? ruleUID,
    required String? body,
  }) {
    final Uri $url = Uri.parse('/rules/${ruleUID}/enable');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<ActionDTO>>> _rulesRuleUIDActionsGet(
      {required String? ruleUID}) {
    final Uri $url = Uri.parse('/rules/${ruleUID}/actions');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<ActionDTO>, ActionDTO>($request);
  }

  @override
  Future<Response<EnrichedRuleDTO>> _rulesRuleUIDGet(
      {required String? ruleUID}) {
    final Uri $url = Uri.parse('/rules/${ruleUID}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<EnrichedRuleDTO, EnrichedRuleDTO>($request);
  }

  @override
  Future<Response<dynamic>> _rulesRuleUIDPut({
    required String? ruleUID,
    required RuleDTO? body,
  }) {
    final Uri $url = Uri.parse('/rules/${ruleUID}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _rulesRuleUIDDelete({required String? ruleUID}) {
    final Uri $url = Uri.parse('/rules/${ruleUID}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<ConditionDTO>>> _rulesRuleUIDConditionsGet(
      {required String? ruleUID}) {
    final Uri $url = Uri.parse('/rules/${ruleUID}/conditions');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<ConditionDTO>, ConditionDTO>($request);
  }

  @override
  Future<Response<String>> _rulesRuleUIDConfigGet({required String? ruleUID}) {
    final Uri $url = Uri.parse('/rules/${ruleUID}/config');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<dynamic>> _rulesRuleUIDConfigPut({
    required String? ruleUID,
    required Object? body,
  }) {
    final Uri $url = Uri.parse('/rules/${ruleUID}/config');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<ModuleDTO>> _rulesRuleUIDModuleCategoryIdGet({
    required String? ruleUID,
    required String? moduleCategory,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/rules/${ruleUID}/${moduleCategory}/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<ModuleDTO, ModuleDTO>($request);
  }

  @override
  Future<Response<String>> _rulesRuleUIDModuleCategoryIdConfigGet({
    required String? ruleUID,
    required String? moduleCategory,
    required String? id,
  }) {
    final Uri $url =
        Uri.parse('/rules/${ruleUID}/${moduleCategory}/${id}/config');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _rulesRuleUIDModuleCategoryIdConfigParamGet({
    required String? ruleUID,
    required String? moduleCategory,
    required String? id,
    required String? param,
  }) {
    final Uri $url =
        Uri.parse('/rules/${ruleUID}/${moduleCategory}/${id}/config/${param}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<dynamic>> _rulesRuleUIDModuleCategoryIdConfigParamPut({
    required String? ruleUID,
    required String? moduleCategory,
    required String? id,
    required String? param,
    required String? body,
  }) {
    final Uri $url =
        Uri.parse('/rules/${ruleUID}/${moduleCategory}/${id}/config/${param}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<TriggerDTO>>> _rulesRuleUIDTriggersGet(
      {required String? ruleUID}) {
    final Uri $url = Uri.parse('/rules/${ruleUID}/triggers');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<TriggerDTO>, TriggerDTO>($request);
  }

  @override
  Future<Response<dynamic>> _rulesRuleUIDRunnowPost({
    required String? ruleUID,
    required Object? body,
  }) {
    final Uri $url = Uri.parse('/rules/${ruleUID}/runnow');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<RuleExecution>>> _rulesScheduleSimulationsGet({
    String? from,
    String? until,
  }) {
    final Uri $url = Uri.parse('/rules/schedule/simulations');
    final Map<String, dynamic> $params = <String, dynamic>{
      'from': from,
      'until': until,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<RuleExecution>, RuleExecution>($request);
  }

  @override
  Future<Response<List<Template>>> _templatesGet({String? acceptLanguage}) {
    final Uri $url = Uri.parse('/templates');
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<List<Template>, Template>($request);
  }

  @override
  Future<Response<Template>> _templatesTemplateUIDGet({
    String? acceptLanguage,
    required String? templateUID,
  }) {
    final Uri $url = Uri.parse('/templates/${templateUID}');
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<Template, Template>($request);
  }

  @override
  Future<Response<String>> _actionsThingUIDActionUidPost({
    required String? thingUID,
    required String? actionUid,
    String? acceptLanguage,
    required Object? body,
  }) {
    final Uri $url = Uri.parse('/actions/${thingUID}/${actionUid}');
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<List<ThingActionDTO>>> _actionsThingUIDGet({
    required String? thingUID,
    String? acceptLanguage,
  }) {
    final Uri $url = Uri.parse('/actions/${thingUID}');
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<List<ThingActionDTO>, ThingActionDTO>($request);
  }

  @override
  Future<Response<String>> _uuidGet() {
    final Uri $url = Uri.parse('/uuid');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<AudioSinkDTO>> _audioDefaultsinkGet(
      {String? acceptLanguage}) {
    final Uri $url = Uri.parse('/audio/defaultsink');
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<AudioSinkDTO, AudioSinkDTO>($request);
  }

  @override
  Future<Response<AudioSourceDTO>> _audioDefaultsourceGet(
      {String? acceptLanguage}) {
    final Uri $url = Uri.parse('/audio/defaultsource');
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<AudioSourceDTO, AudioSourceDTO>($request);
  }

  @override
  Future<Response<List<AudioSinkDTO>>> _audioSinksGet(
      {String? acceptLanguage}) {
    final Uri $url = Uri.parse('/audio/sinks');
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<List<AudioSinkDTO>, AudioSinkDTO>($request);
  }

  @override
  Future<Response<List<AudioSourceDTO>>> _audioSourcesGet(
      {String? acceptLanguage}) {
    final Uri $url = Uri.parse('/audio/sources');
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<List<AudioSourceDTO>, AudioSourceDTO>($request);
  }

  @override
  Future<Response<dynamic>> _authLogoutPost(
      {required Map<String, String> body}) {
    final Uri $url = Uri.parse('/auth/logout');
    final Map<String, String> $headers = {
      'content-type': 'application/x-www-form-urlencoded',
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>(
      $request,
      requestConverter: FormUrlEncodedConverter.requestFactory,
    );
  }

  @override
  Future<Response<List<UserApiTokenDTO>>> _authApitokensGet() {
    final Uri $url = Uri.parse('/auth/apitokens');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<UserApiTokenDTO>, UserApiTokenDTO>($request);
  }

  @override
  Future<Response<List<UserSessionDTO>>> _authSessionsGet() {
    final Uri $url = Uri.parse('/auth/sessions');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<UserSessionDTO>, UserSessionDTO>($request);
  }

  @override
  Future<Response<TokenResponseDTO>> _authTokenPost({
    bool? useCookie,
    required Map<String, String> body,
  }) {
    final Uri $url = Uri.parse('/auth/token');
    final Map<String, dynamic> $params = <String, dynamic>{
      'useCookie': useCookie
    };
    final Map<String, String> $headers = {
      'content-type': 'application/x-www-form-urlencoded',
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
      headers: $headers,
    );
    return client.send<TokenResponseDTO, TokenResponseDTO>(
      $request,
      requestConverter: FormUrlEncodedConverter.requestFactory,
    );
  }

  @override
  Future<Response<dynamic>> _authApitokensNameDelete({required String? name}) {
    final Uri $url = Uri.parse('/auth/apitokens/${name}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<Addon>>> _addonsGet({
    String? acceptLanguage,
    String? serviceId,
  }) {
    final Uri $url = Uri.parse('/addons');
    final Map<String, dynamic> $params = <String, dynamic>{
      'serviceId': serviceId
    };
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<List<Addon>, Addon>($request);
  }

  @override
  Future<Response<Addon>> _addonsAddonIdGet({
    String? acceptLanguage,
    required String? addonId,
    String? serviceId,
  }) {
    final Uri $url = Uri.parse('/addons/${addonId}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'serviceId': serviceId
    };
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<Addon, Addon>($request);
  }

  @override
  Future<Response<String>> _addonsAddonIdConfigGet({
    required String? addonId,
    String? serviceId,
  }) {
    final Uri $url = Uri.parse('/addons/${addonId}/config');
    final Map<String, dynamic> $params = <String, dynamic>{
      'serviceId': serviceId
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _addonsAddonIdConfigPut({
    required String? addonId,
    String? serviceId,
    required Object? body,
  }) {
    final Uri $url = Uri.parse('/addons/${addonId}/config');
    final Map<String, dynamic> $params = <String, dynamic>{
      'serviceId': serviceId
    };
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<List<AddonType>>> _addonsServicesGet(
      {String? acceptLanguage}) {
    final Uri $url = Uri.parse('/addons/services');
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<List<AddonType>, AddonType>($request);
  }

  @override
  Future<Response<List<AddonType>>> _addonsTypesGet({
    String? acceptLanguage,
    String? serviceId,
  }) {
    final Uri $url = Uri.parse('/addons/types');
    final Map<String, dynamic> $params = <String, dynamic>{
      'serviceId': serviceId
    };
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<List<AddonType>, AddonType>($request);
  }

  @override
  Future<Response<dynamic>> _addonsAddonIdInstallPost({
    required String? addonId,
    String? serviceId,
  }) {
    final Uri $url = Uri.parse('/addons/${addonId}/install');
    final Map<String, dynamic> $params = <String, dynamic>{
      'serviceId': serviceId
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _addonsUrlUrlInstallPost({required String? url}) {
    final Uri $url = Uri.parse('/addons/url/${url}/install');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _addonsAddonIdUninstallPost({
    required String? addonId,
    String? serviceId,
  }) {
    final Uri $url = Uri.parse('/addons/${addonId}/uninstall');
    final Map<String, dynamic> $params = <String, dynamic>{
      'serviceId': serviceId
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<ChannelTypeDTO>>> _channelTypesGet({
    String? acceptLanguage,
    String? prefixes,
  }) {
    final Uri $url = Uri.parse('/channel-types');
    final Map<String, dynamic> $params = <String, dynamic>{
      'prefixes': prefixes
    };
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<List<ChannelTypeDTO>, ChannelTypeDTO>($request);
  }

  @override
  Future<Response<ChannelTypeDTO>> _channelTypesChannelTypeUIDGet({
    required String? channelTypeUID,
    String? acceptLanguage,
  }) {
    final Uri $url = Uri.parse('/channel-types/${channelTypeUID}');
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<ChannelTypeDTO, ChannelTypeDTO>($request);
  }

  @override
  Future<Response<List<String>>>
      _channelTypesChannelTypeUIDLinkableItemTypesGet(
          {required String? channelTypeUID}) {
    final Uri $url =
        Uri.parse('/channel-types/${channelTypeUID}/linkableItemTypes');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<String>, String>($request);
  }

  @override
  Future<Response<List<ConfigDescriptionDTO>>> _configDescriptionsGet({
    String? acceptLanguage,
    String? scheme,
  }) {
    final Uri $url = Uri.parse('/config-descriptions');
    final Map<String, dynamic> $params = <String, dynamic>{'scheme': scheme};
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client
        .send<List<ConfigDescriptionDTO>, ConfigDescriptionDTO>($request);
  }

  @override
  Future<Response<ConfigDescriptionDTO>> _configDescriptionsUriGet({
    String? acceptLanguage,
    required String? uri,
  }) {
    final Uri $url = Uri.parse('/config-descriptions/${uri}');
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<ConfigDescriptionDTO, ConfigDescriptionDTO>($request);
  }

  @override
  Future<Response<List<String>>> _discoveryGet() {
    final Uri $url = Uri.parse('/discovery');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<String>, String>($request);
  }

  @override
  Future<Response<int>> _discoveryBindingsBindingIdScanPost(
      {required String? bindingId}) {
    final Uri $url = Uri.parse('/discovery/bindings/${bindingId}/scan');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<int, int>($request);
  }

  @override
  Future<Response<dynamic>> _inboxThingUIDApprovePost({
    String? acceptLanguage,
    required String? thingUID,
    String? newThingId,
    required String? body,
  }) {
    final Uri $url = Uri.parse('/inbox/${thingUID}/approve');
    final Map<String, dynamic> $params = <String, dynamic>{
      'newThingId': newThingId
    };
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _inboxThingUIDDelete({required String? thingUID}) {
    final Uri $url = Uri.parse('/inbox/${thingUID}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<DiscoveryResultDTO>>> _inboxGet() {
    final Uri $url = Uri.parse('/inbox');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<DiscoveryResultDTO>, DiscoveryResultDTO>($request);
  }

  @override
  Future<Response<dynamic>> _inboxThingUIDIgnorePost(
      {required String? thingUID}) {
    final Uri $url = Uri.parse('/inbox/${thingUID}/ignore');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _inboxThingUIDUnignorePost(
      {required String? thingUID}) {
    final Uri $url = Uri.parse('/inbox/${thingUID}/unignore');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _itemsItemNameMembersMemberItemNamePut({
    required String? itemName,
    required String? memberItemName,
  }) {
    final Uri $url = Uri.parse('/items/${itemName}/members/${memberItemName}');
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _itemsItemNameMembersMemberItemNameDelete({
    required String? itemName,
    required String? memberItemName,
  }) {
    final Uri $url = Uri.parse('/items/${itemName}/members/${memberItemName}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _itemsItemnameMetadataNamespacePut({
    required String? itemname,
    required String? namespace,
    required MetadataDTO? body,
  }) {
    final Uri $url = Uri.parse('/items/${itemname}/metadata/${namespace}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _itemsItemnameMetadataNamespaceDelete({
    required String? itemname,
    required String? namespace,
  }) {
    final Uri $url = Uri.parse('/items/${itemname}/metadata/${namespace}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _itemsItemnameTagsTagPut({
    required String? itemname,
    required String? tag,
  }) {
    final Uri $url = Uri.parse('/items/${itemname}/tags/${tag}');
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _itemsItemnameTagsTagDelete({
    required String? itemname,
    required String? tag,
  }) {
    final Uri $url = Uri.parse('/items/${itemname}/tags/${tag}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<EnrichedItemDTO>> _itemsItemnameGet({
    String? acceptLanguage,
    String? metadata,
    bool? recursive,
    required String? itemname,
  }) {
    final Uri $url = Uri.parse('/items/${itemname}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'metadata': metadata,
      'recursive': recursive,
    };
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<EnrichedItemDTO, EnrichedItemDTO>($request);
  }

  @override
  Future<Response<EnrichedItemDTO>> _itemsItemnamePut({
    String? acceptLanguage,
    required String? itemname,
    required GroupItemDTO? body,
  }) {
    final Uri $url = Uri.parse('/items/${itemname}');
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<EnrichedItemDTO, EnrichedItemDTO>($request);
  }

  @override
  Future<Response<dynamic>> _itemsItemnamePost({
    required String? itemname,
    required String? body,
  }) {
    final Uri $url = Uri.parse('/items/${itemname}');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _itemsItemnameDelete({required String? itemname}) {
    final Uri $url = Uri.parse('/items/${itemname}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<EnrichedItemDTO>>> _itemsGet({
    String? acceptLanguage,
    String? type,
    String? tags,
    String? metadata,
    bool? recursive,
    String? fields,
    bool? staticDataOnly,
  }) {
    final Uri $url = Uri.parse('/items');
    final Map<String, dynamic> $params = <String, dynamic>{
      'type': type,
      'tags': tags,
      'metadata': metadata,
      'recursive': recursive,
      'fields': fields,
      'staticDataOnly': staticDataOnly,
    };
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<List<EnrichedItemDTO>, EnrichedItemDTO>($request);
  }

  @override
  Future<Response<String>> _itemsPut({required List<GroupItemDTO>? body}) {
    final Uri $url = Uri.parse('/items');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _itemsItemnameStateGet({required String? itemname}) {
    final Uri $url = Uri.parse('/items/${itemname}/state');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<dynamic>> _itemsItemnameStatePut({
    String? acceptLanguage,
    required String? itemname,
    required String? body,
  }) {
    final Uri $url = Uri.parse('/items/${itemname}/state');
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<String>> _itemsItemnameMetadataNamespacesGet({
    required String? itemname,
    String? acceptLanguage,
  }) {
    final Uri $url = Uri.parse('/items/${itemname}/metadata/namespaces');
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<dynamic>> _itemsItemNameSemanticSemanticClassGet({
    String? acceptLanguage,
    required String? itemName,
    required String? semanticClass,
  }) {
    final Uri $url = Uri.parse('/items/${itemName}/semantic/${semanticClass}');
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _itemsMetadataPurgePost() {
    final Uri $url = Uri.parse('/items/metadata/purge');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<EnrichedItemChannelLinkDTO>>> _linksGet({
    String? channelUID,
    String? itemName,
  }) {
    final Uri $url = Uri.parse('/links');
    final Map<String, dynamic> $params = <String, dynamic>{
      'channelUID': channelUID,
      'itemName': itemName,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<EnrichedItemChannelLinkDTO>,
        EnrichedItemChannelLinkDTO>($request);
  }

  @override
  Future<Response<EnrichedItemChannelLinkDTO>> _linksItemNameChannelUIDGet({
    required String? itemName,
    required String? channelUID,
  }) {
    final Uri $url = Uri.parse('/links/${itemName}/${channelUID}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<EnrichedItemChannelLinkDTO, EnrichedItemChannelLinkDTO>($request);
  }

  @override
  Future<Response<dynamic>> _linksItemNameChannelUIDPut({
    required String? itemName,
    required String? channelUID,
    required ItemChannelLinkDTO? body,
  }) {
    final Uri $url = Uri.parse('/links/${itemName}/${channelUID}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _linksItemNameChannelUIDDelete({
    required String? itemName,
    required String? channelUID,
  }) {
    final Uri $url = Uri.parse('/links/${itemName}/${channelUID}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _linksPurgePost() {
    final Uri $url = Uri.parse('/links/purge');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _linksObjectDelete({required String? object}) {
    final Uri $url = Uri.parse('/links/${object}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<PersistenceServiceConfigurationDTO>> _persistenceServiceIdGet(
      {required String? serviceId}) {
    final Uri $url = Uri.parse('/persistence/${serviceId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<PersistenceServiceConfigurationDTO,
        PersistenceServiceConfigurationDTO>($request);
  }

  @override
  Future<Response<PersistenceServiceConfigurationDTO>>
      _persistenceServiceIdPut({
    required String? serviceId,
    required PersistenceServiceConfigurationDTO? body,
  }) {
    final Uri $url = Uri.parse('/persistence/${serviceId}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<PersistenceServiceConfigurationDTO,
        PersistenceServiceConfigurationDTO>($request);
  }

  @override
  Future<Response<dynamic>> _persistenceServiceIdDelete(
      {required String? serviceId}) {
    final Uri $url = Uri.parse('/persistence/${serviceId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<ItemHistoryDTO>> _persistenceItemsItemnameGet({
    String? serviceId,
    required String? itemname,
    String? starttime,
    String? endtime,
    int? page,
    int? pagelength,
    bool? boundary,
  }) {
    final Uri $url = Uri.parse('/persistence/items/${itemname}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'serviceId': serviceId,
      'starttime': starttime,
      'endtime': endtime,
      'page': page,
      'pagelength': pagelength,
      'boundary': boundary,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<ItemHistoryDTO, ItemHistoryDTO>($request);
  }

  @override
  Future<Response<dynamic>> _persistenceItemsItemnamePut({
    String? serviceId,
    required String? itemname,
    required String? time,
    required String? state,
  }) {
    final Uri $url = Uri.parse('/persistence/items/${itemname}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'serviceId': serviceId,
      'time': time,
      'state': state,
    };
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<String>>> _persistenceItemsItemnameDelete({
    required String? serviceId,
    required String? itemname,
    required String? starttime,
    required String? endtime,
  }) {
    final Uri $url = Uri.parse('/persistence/items/${itemname}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'serviceId': serviceId,
      'starttime': starttime,
      'endtime': endtime,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<String>, String>($request);
  }

  @override
  Future<Response<List<PersistenceItemInfo>>> _persistenceItemsGet(
      {String? serviceId}) {
    final Uri $url = Uri.parse('/persistence/items');
    final Map<String, dynamic> $params = <String, dynamic>{
      'serviceId': serviceId
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<List<PersistenceItemInfo>, PersistenceItemInfo>($request);
  }

  @override
  Future<Response<List<PersistenceServiceDTO>>> _persistenceGet(
      {String? acceptLanguage}) {
    final Uri $url = Uri.parse('/persistence');
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client
        .send<List<PersistenceServiceDTO>, PersistenceServiceDTO>($request);
  }

  @override
  Future<Response<List<ProfileTypeDTO>>> _profileTypesGet({
    String? acceptLanguage,
    String? channelTypeUID,
    String? itemType,
  }) {
    final Uri $url = Uri.parse('/profile-types');
    final Map<String, dynamic> $params = <String, dynamic>{
      'channelTypeUID': channelTypeUID,
      'itemType': itemType,
    };
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<List<ProfileTypeDTO>, ProfileTypeDTO>($request);
  }

  @override
  Future<Response<String>> _servicesServiceIdConfigGet(
      {required String? serviceId}) {
    final Uri $url = Uri.parse('/services/${serviceId}/config');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _servicesServiceIdConfigPut({
    String? acceptLanguage,
    required String? serviceId,
    required Object? body,
  }) {
    final Uri $url = Uri.parse('/services/${serviceId}/config');
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _servicesServiceIdConfigDelete(
      {required String? serviceId}) {
    final Uri $url = Uri.parse('/services/${serviceId}/config');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<List<ConfigurableServiceDTO>>> _servicesGet(
      {String? acceptLanguage}) {
    final Uri $url = Uri.parse('/services');
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client
        .send<List<ConfigurableServiceDTO>, ConfigurableServiceDTO>($request);
  }

  @override
  Future<Response<ConfigurableServiceDTO>> _servicesServiceIdGet({
    String? acceptLanguage,
    required String? serviceId,
  }) {
    final Uri $url = Uri.parse('/services/${serviceId}');
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client
        .send<ConfigurableServiceDTO, ConfigurableServiceDTO>($request);
  }

  @override
  Future<Response<List<ConfigurableServiceDTO>>> _servicesServiceIdContextsGet({
    String? acceptLanguage,
    required String? serviceId,
  }) {
    final Uri $url = Uri.parse('/services/${serviceId}/contexts');
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client
        .send<List<ConfigurableServiceDTO>, ConfigurableServiceDTO>($request);
  }

  @override
  Future<Response<List<EnrichedSemanticTagDTO>>> _tagsGet(
      {String? acceptLanguage}) {
    final Uri $url = Uri.parse('/tags');
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client
        .send<List<EnrichedSemanticTagDTO>, EnrichedSemanticTagDTO>($request);
  }

  @override
  Future<Response<EnrichedSemanticTagDTO>> _tagsPost({
    String? acceptLanguage,
    required EnrichedSemanticTagDTO? body,
  }) {
    final Uri $url = Uri.parse('/tags');
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client
        .send<EnrichedSemanticTagDTO, EnrichedSemanticTagDTO>($request);
  }

  @override
  Future<Response<List<EnrichedSemanticTagDTO>>> _tagsTagIdGet({
    String? acceptLanguage,
    required String? tagId,
  }) {
    final Uri $url = Uri.parse('/tags/${tagId}');
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client
        .send<List<EnrichedSemanticTagDTO>, EnrichedSemanticTagDTO>($request);
  }

  @override
  Future<Response<EnrichedSemanticTagDTO>> _tagsTagIdPut({
    String? acceptLanguage,
    required String? tagId,
    required EnrichedSemanticTagDTO? body,
  }) {
    final Uri $url = Uri.parse('/tags/${tagId}');
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client
        .send<EnrichedSemanticTagDTO, EnrichedSemanticTagDTO>($request);
  }

  @override
  Future<Response<dynamic>> _tagsTagIdDelete({
    String? acceptLanguage,
    required String? tagId,
  }) {
    final Uri $url = Uri.parse('/tags/${tagId}');
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<EnrichedThingDTO>>> _thingsGet({
    String? acceptLanguage,
    bool? summary,
    bool? staticDataOnly,
  }) {
    final Uri $url = Uri.parse('/things');
    final Map<String, dynamic> $params = <String, dynamic>{
      'summary': summary,
      'staticDataOnly': staticDataOnly,
    };
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<List<EnrichedThingDTO>, EnrichedThingDTO>($request);
  }

  @override
  Future<Response<EnrichedThingDTO>> _thingsPost({
    String? acceptLanguage,
    required ThingDTO? body,
  }) {
    final Uri $url = Uri.parse('/things');
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<EnrichedThingDTO, EnrichedThingDTO>($request);
  }

  @override
  Future<Response<EnrichedThingDTO>> _thingsThingUIDGet({
    String? acceptLanguage,
    required String? thingUID,
  }) {
    final Uri $url = Uri.parse('/things/${thingUID}');
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<EnrichedThingDTO, EnrichedThingDTO>($request);
  }

  @override
  Future<Response<EnrichedThingDTO>> _thingsThingUIDPut({
    String? acceptLanguage,
    required String? thingUID,
    required ThingDTO? body,
  }) {
    final Uri $url = Uri.parse('/things/${thingUID}');
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<EnrichedThingDTO, EnrichedThingDTO>($request);
  }

  @override
  Future<Response<dynamic>> _thingsThingUIDDelete({
    String? acceptLanguage,
    required String? thingUID,
    bool? force,
  }) {
    final Uri $url = Uri.parse('/things/${thingUID}');
    final Map<String, dynamic> $params = <String, dynamic>{'force': force};
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<ConfigStatusMessage>>> _thingsThingUIDConfigStatusGet({
    String? acceptLanguage,
    required String? thingUID,
  }) {
    final Uri $url = Uri.parse('/things/${thingUID}/config/status');
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client
        .send<List<ConfigStatusMessage>, ConfigStatusMessage>($request);
  }

  @override
  Future<Response<FirmwareStatusDTO>> _thingsThingUIDFirmwareStatusGet({
    String? acceptLanguage,
    required String? thingUID,
  }) {
    final Uri $url = Uri.parse('/things/${thingUID}/firmware/status');
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<FirmwareStatusDTO, FirmwareStatusDTO>($request);
  }

  @override
  Future<Response<List<FirmwareDTO>>> _thingsThingUIDFirmwaresGet({
    required String? thingUID,
    String? acceptLanguage,
  }) {
    final Uri $url = Uri.parse('/things/${thingUID}/firmwares');
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<List<FirmwareDTO>, FirmwareDTO>($request);
  }

  @override
  Future<Response<ThingStatusInfo>> _thingsThingUIDStatusGet({
    String? acceptLanguage,
    required String? thingUID,
  }) {
    final Uri $url = Uri.parse('/things/${thingUID}/status');
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<ThingStatusInfo, ThingStatusInfo>($request);
  }

  @override
  Future<Response<EnrichedThingDTO>> _thingsThingUIDEnablePut({
    String? acceptLanguage,
    required String? thingUID,
    required String? body,
  }) {
    final Uri $url = Uri.parse('/things/${thingUID}/enable');
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<EnrichedThingDTO, EnrichedThingDTO>($request);
  }

  @override
  Future<Response<EnrichedThingDTO>> _thingsThingUIDConfigPut({
    String? acceptLanguage,
    required String? thingUID,
    required Object? body,
  }) {
    final Uri $url = Uri.parse('/things/${thingUID}/config');
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<EnrichedThingDTO, EnrichedThingDTO>($request);
  }

  @override
  Future<Response<dynamic>> _thingsThingUIDFirmwareFirmwareVersionPut({
    String? acceptLanguage,
    required String? thingUID,
    required String? firmwareVersion,
  }) {
    final Uri $url =
        Uri.parse('/things/${thingUID}/firmware/${firmwareVersion}');
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<StrippedThingTypeDTO>>> _thingTypesGet({
    String? acceptLanguage,
    String? bindingId,
  }) {
    final Uri $url = Uri.parse('/thing-types');
    final Map<String, dynamic> $params = <String, dynamic>{
      'bindingId': bindingId
    };
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client
        .send<List<StrippedThingTypeDTO>, StrippedThingTypeDTO>($request);
  }

  @override
  Future<Response<ThingTypeDTO>> _thingTypesThingTypeUIDGet({
    required String? thingTypeUID,
    String? acceptLanguage,
  }) {
    final Uri $url = Uri.parse('/thing-types/${thingTypeUID}');
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<ThingTypeDTO, ThingTypeDTO>($request);
  }

  @override
  Future<Response<RootBean>> _get() {
    final Uri $url = Uri.parse('/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<RootBean, RootBean>($request);
  }

  @override
  Future<Response<SystemInfoBean>> _systeminfoGet() {
    final Uri $url = Uri.parse('/systeminfo');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<SystemInfoBean, SystemInfoBean>($request);
  }

  @override
  Future<Response<UoMInfoBean>> _systeminfoUomGet() {
    final Uri $url = Uri.parse('/systeminfo/uom');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<UoMInfoBean, UoMInfoBean>($request);
  }

  @override
  Future<Response<dynamic>> _sitemapsEventsSubscribePost() {
    final Uri $url = Uri.parse('/sitemaps/events/subscribe');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<PageDTO>> _sitemapsSitemapnamePageidGet({
    String? acceptLanguage,
    required String? sitemapname,
    required String? pageid,
    String? subscriptionid,
    bool? includeHidden,
  }) {
    final Uri $url = Uri.parse('/sitemaps/${sitemapname}/${pageid}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'subscriptionid': subscriptionid,
      'includeHidden': includeHidden,
    };
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<PageDTO, PageDTO>($request);
  }

  @override
  Future<Response<SitemapDTO>> _sitemapsSitemapnameGet({
    String? acceptLanguage,
    required String? sitemapname,
    String? type,
    String? jsoncallback,
    bool? includeHidden,
  }) {
    final Uri $url = Uri.parse('/sitemaps/${sitemapname}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'type': type,
      'jsoncallback': jsoncallback,
      'includeHidden': includeHidden,
    };
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<SitemapDTO, SitemapDTO>($request);
  }

  @override
  Future<Response<dynamic>> _sitemapsEventsSubscriptionidGet({
    required String? subscriptionid,
    String? sitemap,
    String? pageid,
  }) {
    final Uri $url = Uri.parse('/sitemaps/events/${subscriptionid}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'sitemap': sitemap,
      'pageid': pageid,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<SitemapDTO>>> _sitemapsGet() {
    final Uri $url = Uri.parse('/sitemaps');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<SitemapDTO>, SitemapDTO>($request);
  }

  @override
  Future<Response<dynamic>> _eventsStatesGet() {
    final Uri $url = Uri.parse('/events/states');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _eventsGet({String? topics}) {
    final Uri $url = Uri.parse('/events');
    final Map<String, dynamic> $params = <String, dynamic>{'topics': topics};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _eventsStatesConnectionIdPost({
    required String? connectionId,
    required List<String>? body,
  }) {
    final Uri $url = Uri.parse('/events/states/${connectionId}');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<Transformation>> _transformationsUidGet(
      {required String? uid}) {
    final Uri $url = Uri.parse('/transformations/${uid}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<Transformation, Transformation>($request);
  }

  @override
  Future<Response<dynamic>> _transformationsUidPut({
    required String? uid,
    required TransformationDTO? body,
  }) {
    final Uri $url = Uri.parse('/transformations/${uid}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _transformationsUidDelete({required String? uid}) {
    final Uri $url = Uri.parse('/transformations/${uid}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<String>>> _transformationsServicesGet() {
    final Uri $url = Uri.parse('/transformations/services');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<String>, String>($request);
  }

  @override
  Future<Response<List<TransformationDTO>>> _transformationsGet() {
    final Uri $url = Uri.parse('/transformations');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<TransformationDTO>, TransformationDTO>($request);
  }

  @override
  Future<Response<List<RootUIComponent>>> _uiComponentsNamespaceGet({
    required String? namespace,
    bool? summary,
  }) {
    final Uri $url = Uri.parse('/ui/components/${namespace}');
    final Map<String, dynamic> $params = <String, dynamic>{'summary': summary};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<RootUIComponent>, RootUIComponent>($request);
  }

  @override
  Future<Response<RootUIComponent>> _uiComponentsNamespacePost({
    required String? namespace,
    required RootUIComponent? body,
  }) {
    final Uri $url = Uri.parse('/ui/components/${namespace}');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<RootUIComponent, RootUIComponent>($request);
  }

  @override
  Future<Response<RootUIComponent>> _uiComponentsNamespaceComponentUIDGet({
    required String? namespace,
    required String? componentUID,
  }) {
    final Uri $url = Uri.parse('/ui/components/${namespace}/${componentUID}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<RootUIComponent, RootUIComponent>($request);
  }

  @override
  Future<Response<RootUIComponent>> _uiComponentsNamespaceComponentUIDPut({
    required String? namespace,
    required String? componentUID,
    required RootUIComponent? body,
  }) {
    final Uri $url = Uri.parse('/ui/components/${namespace}/${componentUID}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<RootUIComponent, RootUIComponent>($request);
  }

  @override
  Future<Response<dynamic>> _uiComponentsNamespaceComponentUIDDelete({
    required String? namespace,
    required String? componentUID,
  }) {
    final Uri $url = Uri.parse('/ui/components/${namespace}/${componentUID}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<TileDTO>>> _uiTilesGet() {
    final Uri $url = Uri.parse('/ui/tiles');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<TileDTO>, TileDTO>($request);
  }

  @override
  Future<Response<VoiceDTO>> _voiceDefaultvoiceGet() {
    final Uri $url = Uri.parse('/voice/defaultvoice');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<VoiceDTO, VoiceDTO>($request);
  }

  @override
  Future<Response<List<HumanLanguageInterpreterDTO>>> _voiceInterpretersIdGet({
    String? acceptLanguage,
    required String? id,
  }) {
    final Uri $url = Uri.parse('/voice/interpreters/${id}');
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<List<HumanLanguageInterpreterDTO>,
        HumanLanguageInterpreterDTO>($request);
  }

  @override
  Future<Response<List<HumanLanguageInterpreterDTO>>> _voiceInterpretersGet(
      {String? acceptLanguage}) {
    final Uri $url = Uri.parse('/voice/interpreters');
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<List<HumanLanguageInterpreterDTO>,
        HumanLanguageInterpreterDTO>($request);
  }

  @override
  Future<Response<dynamic>> _voiceInterpretersPost({
    String? acceptLanguage,
    required String? body,
  }) {
    final Uri $url = Uri.parse('/voice/interpreters');
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<VoiceDTO>>> _voiceVoicesGet() {
    final Uri $url = Uri.parse('/voice/voices');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<VoiceDTO>, VoiceDTO>($request);
  }

  @override
  Future<Response<dynamic>> _voiceInterpretersIdsPost({
    String? acceptLanguage,
    required List<String>? ids,
    required String? body,
  }) {
    final Uri $url = Uri.parse('/voice/interpreters/${ids}');
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _voiceListenandanswerPost({
    String? acceptLanguage,
    String? sourceId,
    String? sttId,
    String? ttsId,
    String? voiceId,
    List<String>? hliIds,
    String? sinkId,
    String? listeningItem,
  }) {
    final Uri $url = Uri.parse('/voice/listenandanswer');
    final Map<String, dynamic> $params = <String, dynamic>{
      'sourceId': sourceId,
      'sttId': sttId,
      'ttsId': ttsId,
      'voiceId': voiceId,
      'hliIds': hliIds,
      'sinkId': sinkId,
      'listeningItem': listeningItem,
    };
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _voiceSayPost({
    String? voiceid,
    String? sinkid,
    String? volume,
    required String? body,
  }) {
    final Uri $url = Uri.parse('/voice/say');
    final Map<String, dynamic> $params = <String, dynamic>{
      'voiceid': voiceid,
      'sinkid': sinkid,
      'volume': volume,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _voiceDialogStartPost({
    String? acceptLanguage,
    String? sourceId,
    String? ksId,
    String? sttId,
    String? ttsId,
    String? voiceId,
    String? hliIds,
    String? sinkId,
    String? keyword,
    String? listeningItem,
  }) {
    final Uri $url = Uri.parse('/voice/dialog/start');
    final Map<String, dynamic> $params = <String, dynamic>{
      'sourceId': sourceId,
      'ksId': ksId,
      'sttId': sttId,
      'ttsId': ttsId,
      'voiceId': voiceId,
      'hliIds': hliIds,
      'sinkId': sinkId,
      'keyword': keyword,
      'listeningItem': listeningItem,
    };
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _voiceDialogStopPost({String? sourceId}) {
    final Uri $url = Uri.parse('/voice/dialog/stop');
    final Map<String, dynamic> $params = <String, dynamic>{
      'sourceId': sourceId
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<LoggerInfo>> _loggingLoggerNameGet(
      {required String? loggerName}) {
    final Uri $url = Uri.parse('/logging/${loggerName}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<LoggerInfo, LoggerInfo>($request);
  }

  @override
  Future<Response<dynamic>> _loggingLoggerNamePut({
    required String? loggerName,
    required LoggerInfo? body,
  }) {
    final Uri $url = Uri.parse('/logging/${loggerName}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _loggingLoggerNameDelete(
      {required String? loggerName}) {
    final Uri $url = Uri.parse('/logging/${loggerName}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<LoggerBean>> _loggingGet() {
    final Uri $url = Uri.parse('/logging');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<LoggerBean, LoggerBean>($request);
  }

  @override
  Future<Response<List<IconSet>>> _iconsetsGet({String? acceptLanguage}) {
    final Uri $url = Uri.parse('/iconsets');
    final Map<String, String> $headers = {
      if (acceptLanguage != null) 'Accept-Language': acceptLanguage,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<List<IconSet>, IconSet>($request);
  }

  @override
  Future<Response<List<GalleryWidgetsListItem>>>
      _habpanelGalleryGalleryNameWidgetsGet({required String? galleryName}) {
    final Uri $url = Uri.parse('/habpanel/gallery/${galleryName}/widgets');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<List<GalleryWidgetsListItem>, GalleryWidgetsListItem>($request);
  }

  @override
  Future<Response<GalleryItem>> _habpanelGalleryGalleryNameWidgetsIdGet({
    required String? galleryName,
    required String? id,
  }) {
    final Uri $url =
        Uri.parse('/habpanel/gallery/${galleryName}/widgets/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<GalleryItem, GalleryItem>($request);
  }
}
