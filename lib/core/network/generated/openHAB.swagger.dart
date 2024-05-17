// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';
import 'dart:convert';

import 'openHAB.models.swagger.dart';
import 'package:chopper/chopper.dart';

import 'client_mapping.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show MultipartFile;
import 'package:chopper/chopper.dart' as chopper;
import 'openHAB.enums.swagger.dart' as enums;
export 'openHAB.enums.swagger.dart';
export 'openHAB.models.swagger.dart';

part 'openHAB.swagger.chopper.dart';

// **************************************************************************
// SwaggerChopperGenerator
// **************************************************************************

@ChopperApi()
abstract class OpenHAB extends ChopperService {
  static OpenHAB create({
    ChopperClient? client,
    http.Client? httpClient,
    Authenticator? authenticator,
    ErrorConverter? errorConverter,
    Converter? converter,
    Uri? baseUrl,
    List<Interceptor>? interceptors,
  }) {
    if (client != null) {
      return _$OpenHAB(client);
    }

    final newClient = ChopperClient(
        services: [_$OpenHAB()],
        converter: converter ?? $JsonSerializableConverter(),
        interceptors: interceptors ?? [],
        client: httpClient,
        authenticator: authenticator,
        errorConverter: errorConverter,
        baseUrl: baseUrl ?? Uri.parse('http://'));
    return _$OpenHAB(newClient);
  }

  ///Get all available module types.
  ///@param Accept-Language language
  ///@param tags tags for filtering
  ///@param type filtering by action, condition or trigger
  Future<chopper.Response<List<ModuleTypeDTO>>> moduleTypesGet({
    String? acceptLanguage,
    String? tags,
    String? type,
  }) {
    generatedMapping.putIfAbsent(
        ModuleTypeDTO, () => ModuleTypeDTO.fromJsonFactory);

    return _moduleTypesGet(
        acceptLanguage: acceptLanguage?.toString(), tags: tags, type: type);
  }

  ///Get all available module types.
  ///@param Accept-Language language
  ///@param tags tags for filtering
  ///@param type filtering by action, condition or trigger
  @Get(path: '/module-types')
  Future<chopper.Response<List<ModuleTypeDTO>>> _moduleTypesGet({
    @Header('Accept-Language') String? acceptLanguage,
    @Query('tags') String? tags,
    @Query('type') String? type,
  });

  ///Gets a module type corresponding to the given UID.
  ///@param Accept-Language language
  ///@param moduleTypeUID moduleTypeUID
  Future<chopper.Response<ModuleTypeDTO>> moduleTypesModuleTypeUIDGet({
    String? acceptLanguage,
    required String? moduleTypeUID,
  }) {
    generatedMapping.putIfAbsent(
        ModuleTypeDTO, () => ModuleTypeDTO.fromJsonFactory);

    return _moduleTypesModuleTypeUIDGet(
        acceptLanguage: acceptLanguage?.toString(),
        moduleTypeUID: moduleTypeUID);
  }

  ///Gets a module type corresponding to the given UID.
  ///@param Accept-Language language
  ///@param moduleTypeUID moduleTypeUID
  @Get(path: '/module-types/{moduleTypeUID}')
  Future<chopper.Response<ModuleTypeDTO>> _moduleTypesModuleTypeUIDGet({
    @Header('Accept-Language') String? acceptLanguage,
    @Path('moduleTypeUID') required String? moduleTypeUID,
  });

  ///Get available rules, optionally filtered by tags and/or prefix.
  ///@param prefix
  ///@param tags
  ///@param summary summary fields only
  ///@param staticDataOnly provides a cacheable list of values not expected to change regularly and honors the If-Modified-Since header, all other parameters are ignored
  Future<chopper.Response<List<EnrichedRuleDTO>>> rulesGet({
    String? prefix,
    List<String>? tags,
    bool? summary,
    bool? staticDataOnly,
  }) {
    generatedMapping.putIfAbsent(
        EnrichedRuleDTO, () => EnrichedRuleDTO.fromJsonFactory);

    return _rulesGet(
        prefix: prefix,
        tags: tags,
        summary: summary,
        staticDataOnly: staticDataOnly);
  }

  ///Get available rules, optionally filtered by tags and/or prefix.
  ///@param prefix
  ///@param tags
  ///@param summary summary fields only
  ///@param staticDataOnly provides a cacheable list of values not expected to change regularly and honors the If-Modified-Since header, all other parameters are ignored
  @Get(path: '/rules')
  Future<chopper.Response<List<EnrichedRuleDTO>>> _rulesGet({
    @Query('prefix') String? prefix,
    @Query('tags') List<String>? tags,
    @Query('summary') bool? summary,
    @Query('staticDataOnly') bool? staticDataOnly,
  });

  ///Creates a rule.
  Future<chopper.Response> rulesPost({required RuleDTO? body}) {
    return _rulesPost(body: body);
  }

  ///Creates a rule.
  @Post(
    path: '/rules',
    optionalBody: true,
  )
  Future<chopper.Response> _rulesPost({@Body() required RuleDTO? body});

  ///Sets the rule enabled status.
  ///@param ruleUID ruleUID
  Future<chopper.Response> rulesRuleUIDEnablePost({
    required String? ruleUID,
    required String? body,
  }) {
    return _rulesRuleUIDEnablePost(ruleUID: ruleUID, body: body);
  }

  ///Sets the rule enabled status.
  ///@param ruleUID ruleUID
  @Post(
    path: '/rules/{ruleUID}/enable',
    optionalBody: true,
  )
  Future<chopper.Response> _rulesRuleUIDEnablePost({
    @Path('ruleUID') required String? ruleUID,
    @Body() required String? body,
  });

  ///Gets the rule actions.
  ///@param ruleUID ruleUID
  Future<chopper.Response<List<ActionDTO>>> rulesRuleUIDActionsGet(
      {required String? ruleUID}) {
    generatedMapping.putIfAbsent(ActionDTO, () => ActionDTO.fromJsonFactory);

    return _rulesRuleUIDActionsGet(ruleUID: ruleUID);
  }

  ///Gets the rule actions.
  ///@param ruleUID ruleUID
  @Get(path: '/rules/{ruleUID}/actions')
  Future<chopper.Response<List<ActionDTO>>> _rulesRuleUIDActionsGet(
      {@Path('ruleUID') required String? ruleUID});

  ///Gets the rule corresponding to the given UID.
  ///@param ruleUID ruleUID
  Future<chopper.Response<EnrichedRuleDTO>> rulesRuleUIDGet(
      {required String? ruleUID}) {
    generatedMapping.putIfAbsent(
        EnrichedRuleDTO, () => EnrichedRuleDTO.fromJsonFactory);

    return _rulesRuleUIDGet(ruleUID: ruleUID);
  }

  ///Gets the rule corresponding to the given UID.
  ///@param ruleUID ruleUID
  @Get(path: '/rules/{ruleUID}')
  Future<chopper.Response<EnrichedRuleDTO>> _rulesRuleUIDGet(
      {@Path('ruleUID') required String? ruleUID});

  ///Updates an existing rule corresponding to the given UID.
  ///@param ruleUID ruleUID
  Future<chopper.Response> rulesRuleUIDPut({
    required String? ruleUID,
    required RuleDTO? body,
  }) {
    return _rulesRuleUIDPut(ruleUID: ruleUID, body: body);
  }

  ///Updates an existing rule corresponding to the given UID.
  ///@param ruleUID ruleUID
  @Put(
    path: '/rules/{ruleUID}',
    optionalBody: true,
  )
  Future<chopper.Response> _rulesRuleUIDPut({
    @Path('ruleUID') required String? ruleUID,
    @Body() required RuleDTO? body,
  });

  ///Removes an existing rule corresponding to the given UID.
  ///@param ruleUID ruleUID
  Future<chopper.Response> rulesRuleUIDDelete({required String? ruleUID}) {
    return _rulesRuleUIDDelete(ruleUID: ruleUID);
  }

  ///Removes an existing rule corresponding to the given UID.
  ///@param ruleUID ruleUID
  @Delete(path: '/rules/{ruleUID}')
  Future<chopper.Response> _rulesRuleUIDDelete(
      {@Path('ruleUID') required String? ruleUID});

  ///Gets the rule conditions.
  ///@param ruleUID ruleUID
  Future<chopper.Response<List<ConditionDTO>>> rulesRuleUIDConditionsGet(
      {required String? ruleUID}) {
    generatedMapping.putIfAbsent(
        ConditionDTO, () => ConditionDTO.fromJsonFactory);

    return _rulesRuleUIDConditionsGet(ruleUID: ruleUID);
  }

  ///Gets the rule conditions.
  ///@param ruleUID ruleUID
  @Get(path: '/rules/{ruleUID}/conditions')
  Future<chopper.Response<List<ConditionDTO>>> _rulesRuleUIDConditionsGet(
      {@Path('ruleUID') required String? ruleUID});

  ///Gets the rule configuration values.
  ///@param ruleUID ruleUID
  Future<chopper.Response<String>> rulesRuleUIDConfigGet(
      {required String? ruleUID}) {
    return _rulesRuleUIDConfigGet(ruleUID: ruleUID);
  }

  ///Gets the rule configuration values.
  ///@param ruleUID ruleUID
  @Get(path: '/rules/{ruleUID}/config')
  Future<chopper.Response<String>> _rulesRuleUIDConfigGet(
      {@Path('ruleUID') required String? ruleUID});

  ///Sets the rule configuration values.
  ///@param ruleUID ruleUID
  Future<chopper.Response> rulesRuleUIDConfigPut({
    required String? ruleUID,
    required Object? body,
  }) {
    return _rulesRuleUIDConfigPut(ruleUID: ruleUID, body: body);
  }

  ///Sets the rule configuration values.
  ///@param ruleUID ruleUID
  @Put(
    path: '/rules/{ruleUID}/config',
    optionalBody: true,
  )
  Future<chopper.Response> _rulesRuleUIDConfigPut({
    @Path('ruleUID') required String? ruleUID,
    @Body() required Object? body,
  });

  ///Gets the rule's module corresponding to the given Category and ID.
  ///@param ruleUID ruleUID
  ///@param moduleCategory moduleCategory
  ///@param id id
  Future<chopper.Response<ModuleDTO>> rulesRuleUIDModuleCategoryIdGet({
    required String? ruleUID,
    required String? moduleCategory,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(ModuleDTO, () => ModuleDTO.fromJsonFactory);

    return _rulesRuleUIDModuleCategoryIdGet(
        ruleUID: ruleUID, moduleCategory: moduleCategory, id: id);
  }

  ///Gets the rule's module corresponding to the given Category and ID.
  ///@param ruleUID ruleUID
  ///@param moduleCategory moduleCategory
  ///@param id id
  @Get(path: '/rules/{ruleUID}/{moduleCategory}/{id}')
  Future<chopper.Response<ModuleDTO>> _rulesRuleUIDModuleCategoryIdGet({
    @Path('ruleUID') required String? ruleUID,
    @Path('moduleCategory') required String? moduleCategory,
    @Path('id') required String? id,
  });

  ///Gets the module's configuration.
  ///@param ruleUID ruleUID
  ///@param moduleCategory moduleCategory
  ///@param id id
  Future<chopper.Response<String>> rulesRuleUIDModuleCategoryIdConfigGet({
    required String? ruleUID,
    required String? moduleCategory,
    required String? id,
  }) {
    return _rulesRuleUIDModuleCategoryIdConfigGet(
        ruleUID: ruleUID, moduleCategory: moduleCategory, id: id);
  }

  ///Gets the module's configuration.
  ///@param ruleUID ruleUID
  ///@param moduleCategory moduleCategory
  ///@param id id
  @Get(path: '/rules/{ruleUID}/{moduleCategory}/{id}/config')
  Future<chopper.Response<String>> _rulesRuleUIDModuleCategoryIdConfigGet({
    @Path('ruleUID') required String? ruleUID,
    @Path('moduleCategory') required String? moduleCategory,
    @Path('id') required String? id,
  });

  ///Gets the module's configuration parameter.
  ///@param ruleUID ruleUID
  ///@param moduleCategory moduleCategory
  ///@param id id
  ///@param param param
  Future<chopper.Response<String>> rulesRuleUIDModuleCategoryIdConfigParamGet({
    required String? ruleUID,
    required String? moduleCategory,
    required String? id,
    required String? param,
  }) {
    return _rulesRuleUIDModuleCategoryIdConfigParamGet(
        ruleUID: ruleUID, moduleCategory: moduleCategory, id: id, param: param);
  }

  ///Gets the module's configuration parameter.
  ///@param ruleUID ruleUID
  ///@param moduleCategory moduleCategory
  ///@param id id
  ///@param param param
  @Get(path: '/rules/{ruleUID}/{moduleCategory}/{id}/config/{param}')
  Future<chopper.Response<String>> _rulesRuleUIDModuleCategoryIdConfigParamGet({
    @Path('ruleUID') required String? ruleUID,
    @Path('moduleCategory') required String? moduleCategory,
    @Path('id') required String? id,
    @Path('param') required String? param,
  });

  ///Sets the module's configuration parameter value.
  ///@param ruleUID ruleUID
  ///@param moduleCategory moduleCategory
  ///@param id id
  ///@param param param
  Future<chopper.Response> rulesRuleUIDModuleCategoryIdConfigParamPut({
    required String? ruleUID,
    required String? moduleCategory,
    required String? id,
    required String? param,
    required String? body,
  }) {
    return _rulesRuleUIDModuleCategoryIdConfigParamPut(
        ruleUID: ruleUID,
        moduleCategory: moduleCategory,
        id: id,
        param: param,
        body: body);
  }

  ///Sets the module's configuration parameter value.
  ///@param ruleUID ruleUID
  ///@param moduleCategory moduleCategory
  ///@param id id
  ///@param param param
  @Put(
    path: '/rules/{ruleUID}/{moduleCategory}/{id}/config/{param}',
    optionalBody: true,
  )
  Future<chopper.Response> _rulesRuleUIDModuleCategoryIdConfigParamPut({
    @Path('ruleUID') required String? ruleUID,
    @Path('moduleCategory') required String? moduleCategory,
    @Path('id') required String? id,
    @Path('param') required String? param,
    @Body() required String? body,
  });

  ///Gets the rule triggers.
  ///@param ruleUID ruleUID
  Future<chopper.Response<List<TriggerDTO>>> rulesRuleUIDTriggersGet(
      {required String? ruleUID}) {
    generatedMapping.putIfAbsent(TriggerDTO, () => TriggerDTO.fromJsonFactory);

    return _rulesRuleUIDTriggersGet(ruleUID: ruleUID);
  }

  ///Gets the rule triggers.
  ///@param ruleUID ruleUID
  @Get(path: '/rules/{ruleUID}/triggers')
  Future<chopper.Response<List<TriggerDTO>>> _rulesRuleUIDTriggersGet(
      {@Path('ruleUID') required String? ruleUID});

  ///Executes actions of the rule.
  ///@param ruleUID ruleUID
  Future<chopper.Response> rulesRuleUIDRunnowPost({
    required String? ruleUID,
    required Object? body,
  }) {
    return _rulesRuleUIDRunnowPost(ruleUID: ruleUID, body: body);
  }

  ///Executes actions of the rule.
  ///@param ruleUID ruleUID
  @Post(
    path: '/rules/{ruleUID}/runnow',
    optionalBody: true,
  )
  Future<chopper.Response> _rulesRuleUIDRunnowPost({
    @Path('ruleUID') required String? ruleUID,
    @Body() required Object? body,
  });

  ///Simulates the executions of rules filtered by tag 'Schedule' within the given times.
  ///@param from Start time of the simulated rule executions. Will default to the current time. [yyyy-MM-dd'T'HH:mm:ss.SSSZ]
  ///@param until End time of the simulated rule executions. Will default to 30 days after the start time. Must be less than 180 days after the given start time. [yyyy-MM-dd'T'HH:mm:ss.SSSZ]
  Future<chopper.Response<List<RuleExecution>>> rulesScheduleSimulationsGet({
    String? from,
    String? until,
  }) {
    generatedMapping.putIfAbsent(
        RuleExecution, () => RuleExecution.fromJsonFactory);

    return _rulesScheduleSimulationsGet(from: from, until: until);
  }

  ///Simulates the executions of rules filtered by tag 'Schedule' within the given times.
  ///@param from Start time of the simulated rule executions. Will default to the current time. [yyyy-MM-dd'T'HH:mm:ss.SSSZ]
  ///@param until End time of the simulated rule executions. Will default to 30 days after the start time. Must be less than 180 days after the given start time. [yyyy-MM-dd'T'HH:mm:ss.SSSZ]
  @Get(path: '/rules/schedule/simulations')
  Future<chopper.Response<List<RuleExecution>>> _rulesScheduleSimulationsGet({
    @Query('from') String? from,
    @Query('until') String? until,
  });

  ///Get all available templates.
  ///@param Accept-Language language
  Future<chopper.Response<List<Template>>> templatesGet(
      {String? acceptLanguage}) {
    generatedMapping.putIfAbsent(Template, () => Template.fromJsonFactory);

    return _templatesGet(acceptLanguage: acceptLanguage?.toString());
  }

  ///Get all available templates.
  ///@param Accept-Language language
  @Get(path: '/templates')
  Future<chopper.Response<List<Template>>> _templatesGet(
      {@Header('Accept-Language') String? acceptLanguage});

  ///Gets a template corresponding to the given UID.
  ///@param Accept-Language language
  ///@param templateUID templateUID
  Future<chopper.Response<Template>> templatesTemplateUIDGet({
    String? acceptLanguage,
    required String? templateUID,
  }) {
    generatedMapping.putIfAbsent(Template, () => Template.fromJsonFactory);

    return _templatesTemplateUIDGet(
        acceptLanguage: acceptLanguage?.toString(), templateUID: templateUID);
  }

  ///Gets a template corresponding to the given UID.
  ///@param Accept-Language language
  ///@param templateUID templateUID
  @Get(path: '/templates/{templateUID}')
  Future<chopper.Response<Template>> _templatesTemplateUIDGet({
    @Header('Accept-Language') String? acceptLanguage,
    @Path('templateUID') required String? templateUID,
  });

  ///Executes a thing action.
  ///@param thingUID thingUID
  ///@param actionUid action type UID (including scope, separated by '.')
  ///@param Accept-Language language
  Future<chopper.Response<String>> actionsThingUIDActionUidPost({
    required String? thingUID,
    required String? actionUid,
    String? acceptLanguage,
    required Object? body,
  }) {
    return _actionsThingUIDActionUidPost(
        thingUID: thingUID,
        actionUid: actionUid,
        acceptLanguage: acceptLanguage?.toString(),
        body: body);
  }

  ///Executes a thing action.
  ///@param thingUID thingUID
  ///@param actionUid action type UID (including scope, separated by '.')
  ///@param Accept-Language language
  @Post(
    path: '/actions/{thingUID}/{actionUid}',
    optionalBody: true,
  )
  Future<chopper.Response<String>> _actionsThingUIDActionUidPost({
    @Path('thingUID') required String? thingUID,
    @Path('actionUid') required String? actionUid,
    @Header('Accept-Language') String? acceptLanguage,
    @Body() required Object? body,
  });

  ///Get all available actions for provided thing UID
  ///@param thingUID thingUID
  ///@param Accept-Language language
  Future<chopper.Response<List<ThingActionDTO>>> actionsThingUIDGet({
    required String? thingUID,
    String? acceptLanguage,
  }) {
    generatedMapping.putIfAbsent(
        ThingActionDTO, () => ThingActionDTO.fromJsonFactory);

    return _actionsThingUIDGet(
        thingUID: thingUID, acceptLanguage: acceptLanguage?.toString());
  }

  ///Get all available actions for provided thing UID
  ///@param thingUID thingUID
  ///@param Accept-Language language
  @Get(path: '/actions/{thingUID}')
  Future<chopper.Response<List<ThingActionDTO>>> _actionsThingUIDGet({
    @Path('thingUID') required String? thingUID,
    @Header('Accept-Language') String? acceptLanguage,
  });

  ///A unified unique id.
  Future<chopper.Response<String>> uuidGet() {
    return _uuidGet();
  }

  ///A unified unique id.
  @Get(path: '/uuid')
  Future<chopper.Response<String>> _uuidGet();

  ///Get the default sink if defined or the first available sink.
  ///@param Accept-Language language
  Future<chopper.Response<AudioSinkDTO>> audioDefaultsinkGet(
      {String? acceptLanguage}) {
    generatedMapping.putIfAbsent(
        AudioSinkDTO, () => AudioSinkDTO.fromJsonFactory);

    return _audioDefaultsinkGet(acceptLanguage: acceptLanguage?.toString());
  }

  ///Get the default sink if defined or the first available sink.
  ///@param Accept-Language language
  @Get(path: '/audio/defaultsink')
  Future<chopper.Response<AudioSinkDTO>> _audioDefaultsinkGet(
      {@Header('Accept-Language') String? acceptLanguage});

  ///Get the default source if defined or the first available source.
  ///@param Accept-Language language
  Future<chopper.Response<AudioSourceDTO>> audioDefaultsourceGet(
      {String? acceptLanguage}) {
    generatedMapping.putIfAbsent(
        AudioSourceDTO, () => AudioSourceDTO.fromJsonFactory);

    return _audioDefaultsourceGet(acceptLanguage: acceptLanguage?.toString());
  }

  ///Get the default source if defined or the first available source.
  ///@param Accept-Language language
  @Get(path: '/audio/defaultsource')
  Future<chopper.Response<AudioSourceDTO>> _audioDefaultsourceGet(
      {@Header('Accept-Language') String? acceptLanguage});

  ///Get the list of all sinks.
  ///@param Accept-Language language
  Future<chopper.Response<List<AudioSinkDTO>>> audioSinksGet(
      {String? acceptLanguage}) {
    generatedMapping.putIfAbsent(
        AudioSinkDTO, () => AudioSinkDTO.fromJsonFactory);

    return _audioSinksGet(acceptLanguage: acceptLanguage?.toString());
  }

  ///Get the list of all sinks.
  ///@param Accept-Language language
  @Get(path: '/audio/sinks')
  Future<chopper.Response<List<AudioSinkDTO>>> _audioSinksGet(
      {@Header('Accept-Language') String? acceptLanguage});

  ///Get the list of all sources.
  ///@param Accept-Language language
  Future<chopper.Response<List<AudioSourceDTO>>> audioSourcesGet(
      {String? acceptLanguage}) {
    generatedMapping.putIfAbsent(
        AudioSourceDTO, () => AudioSourceDTO.fromJsonFactory);

    return _audioSourcesGet(acceptLanguage: acceptLanguage?.toString());
  }

  ///Get the list of all sources.
  ///@param Accept-Language language
  @Get(path: '/audio/sources')
  Future<chopper.Response<List<AudioSourceDTO>>> _audioSourcesGet(
      {@Header('Accept-Language') String? acceptLanguage});

  ///Delete the session associated with a refresh token.
  Future<chopper.Response> authLogoutPost({required Map<String, String> body}) {
    return _authLogoutPost(body: body);
  }

  ///Delete the session associated with a refresh token.
  @Post(
    path: '/auth/logout',
    headers: {contentTypeKey: formEncodedHeaders},
  )
  @FactoryConverter(request: FormUrlEncodedConverter.requestFactory)
  Future<chopper.Response> _authLogoutPost(
      {@Body() required Map<String, String> body});

  ///List the API tokens associated to the authenticated user.
  Future<chopper.Response<List<UserApiTokenDTO>>> authApitokensGet() {
    generatedMapping.putIfAbsent(
        UserApiTokenDTO, () => UserApiTokenDTO.fromJsonFactory);

    return _authApitokensGet();
  }

  ///List the API tokens associated to the authenticated user.
  @Get(path: '/auth/apitokens')
  Future<chopper.Response<List<UserApiTokenDTO>>> _authApitokensGet();

  ///List the sessions associated to the authenticated user.
  Future<chopper.Response<List<UserSessionDTO>>> authSessionsGet() {
    generatedMapping.putIfAbsent(
        UserSessionDTO, () => UserSessionDTO.fromJsonFactory);

    return _authSessionsGet();
  }

  ///List the sessions associated to the authenticated user.
  @Get(path: '/auth/sessions')
  Future<chopper.Response<List<UserSessionDTO>>> _authSessionsGet();

  ///Get access and refresh tokens.
  ///@param useCookie
  Future<chopper.Response<TokenResponseDTO>> authTokenPost({
    bool? useCookie,
    required Map<String, String> body,
  }) {
    generatedMapping.putIfAbsent(
        TokenResponseDTO, () => TokenResponseDTO.fromJsonFactory);

    return _authTokenPost(useCookie: useCookie, body: body);
  }

  ///Get access and refresh tokens.
  ///@param useCookie
  @Post(
    path: '/auth/token',
    headers: {contentTypeKey: formEncodedHeaders},
  )
  @FactoryConverter(request: FormUrlEncodedConverter.requestFactory)
  Future<chopper.Response<TokenResponseDTO>> _authTokenPost({
    @Query('useCookie') bool? useCookie,
    @Body() required Map<String, String> body,
  });

  ///Revoke a specified API token associated to the authenticated user.
  ///@param name
  Future<chopper.Response> authApitokensNameDelete({required String? name}) {
    return _authApitokensNameDelete(name: name);
  }

  ///Revoke a specified API token associated to the authenticated user.
  ///@param name
  @Delete(path: '/auth/apitokens/{name}')
  Future<chopper.Response> _authApitokensNameDelete(
      {@Path('name') required String? name});

  ///Get all add-ons.
  ///@param Accept-Language language
  ///@param serviceId service ID
  Future<chopper.Response<List<Addon>>> addonsGet({
    String? acceptLanguage,
    String? serviceId,
  }) {
    generatedMapping.putIfAbsent(Addon, () => Addon.fromJsonFactory);

    return _addonsGet(
        acceptLanguage: acceptLanguage?.toString(), serviceId: serviceId);
  }

  ///Get all add-ons.
  ///@param Accept-Language language
  ///@param serviceId service ID
  @Get(path: '/addons')
  Future<chopper.Response<List<Addon>>> _addonsGet({
    @Header('Accept-Language') String? acceptLanguage,
    @Query('serviceId') String? serviceId,
  });

  ///Get add-on with given ID.
  ///@param Accept-Language language
  ///@param addonId addon ID
  ///@param serviceId service ID
  Future<chopper.Response<Addon>> addonsAddonIdGet({
    String? acceptLanguage,
    required String? addonId,
    String? serviceId,
  }) {
    generatedMapping.putIfAbsent(Addon, () => Addon.fromJsonFactory);

    return _addonsAddonIdGet(
        acceptLanguage: acceptLanguage?.toString(),
        addonId: addonId,
        serviceId: serviceId);
  }

  ///Get add-on with given ID.
  ///@param Accept-Language language
  ///@param addonId addon ID
  ///@param serviceId service ID
  @Get(path: '/addons/{addonId}')
  Future<chopper.Response<Addon>> _addonsAddonIdGet({
    @Header('Accept-Language') String? acceptLanguage,
    @Path('addonId') required String? addonId,
    @Query('serviceId') String? serviceId,
  });

  ///Get add-on configuration for given add-on ID.
  ///@param addonId addon ID
  ///@param serviceId service ID
  Future<chopper.Response<String>> addonsAddonIdConfigGet({
    required String? addonId,
    String? serviceId,
  }) {
    return _addonsAddonIdConfigGet(addonId: addonId, serviceId: serviceId);
  }

  ///Get add-on configuration for given add-on ID.
  ///@param addonId addon ID
  ///@param serviceId service ID
  @Get(path: '/addons/{addonId}/config')
  Future<chopper.Response<String>> _addonsAddonIdConfigGet({
    @Path('addonId') required String? addonId,
    @Query('serviceId') String? serviceId,
  });

  ///Updates an add-on configuration for given ID and returns the old configuration.
  ///@param addonId Add-on id
  ///@param serviceId service ID
  Future<chopper.Response<String>> addonsAddonIdConfigPut({
    required String? addonId,
    String? serviceId,
    required Object? body,
  }) {
    return _addonsAddonIdConfigPut(
        addonId: addonId, serviceId: serviceId, body: body);
  }

  ///Updates an add-on configuration for given ID and returns the old configuration.
  ///@param addonId Add-on id
  ///@param serviceId service ID
  @Put(
    path: '/addons/{addonId}/config',
    optionalBody: true,
  )
  Future<chopper.Response<String>> _addonsAddonIdConfigPut({
    @Path('addonId') required String? addonId,
    @Query('serviceId') String? serviceId,
    @Body() required Object? body,
  });

  ///Get all add-on types.
  ///@param Accept-Language language
  Future<chopper.Response<List<AddonType>>> addonsServicesGet(
      {String? acceptLanguage}) {
    generatedMapping.putIfAbsent(AddonType, () => AddonType.fromJsonFactory);

    return _addonsServicesGet(acceptLanguage: acceptLanguage?.toString());
  }

  ///Get all add-on types.
  ///@param Accept-Language language
  @Get(path: '/addons/services')
  Future<chopper.Response<List<AddonType>>> _addonsServicesGet(
      {@Header('Accept-Language') String? acceptLanguage});

  ///Get add-on services.
  ///@param Accept-Language language
  ///@param serviceId service ID
  Future<chopper.Response<List<AddonType>>> addonsTypesGet({
    String? acceptLanguage,
    String? serviceId,
  }) {
    generatedMapping.putIfAbsent(AddonType, () => AddonType.fromJsonFactory);

    return _addonsTypesGet(
        acceptLanguage: acceptLanguage?.toString(), serviceId: serviceId);
  }

  ///Get add-on services.
  ///@param Accept-Language language
  ///@param serviceId service ID
  @Get(path: '/addons/types')
  Future<chopper.Response<List<AddonType>>> _addonsTypesGet({
    @Header('Accept-Language') String? acceptLanguage,
    @Query('serviceId') String? serviceId,
  });

  ///Installs the add-on with the given ID.
  ///@param addonId addon ID
  ///@param serviceId service ID
  Future<chopper.Response> addonsAddonIdInstallPost({
    required String? addonId,
    String? serviceId,
  }) {
    return _addonsAddonIdInstallPost(addonId: addonId, serviceId: serviceId);
  }

  ///Installs the add-on with the given ID.
  ///@param addonId addon ID
  ///@param serviceId service ID
  @Post(
    path: '/addons/{addonId}/install',
    optionalBody: true,
  )
  Future<chopper.Response> _addonsAddonIdInstallPost({
    @Path('addonId') required String? addonId,
    @Query('serviceId') String? serviceId,
  });

  ///Installs the add-on from the given URL.
  ///@param url addon install URL
  Future<chopper.Response> addonsUrlUrlInstallPost({required String? url}) {
    return _addonsUrlUrlInstallPost(url: url);
  }

  ///Installs the add-on from the given URL.
  ///@param url addon install URL
  @Post(
    path: '/addons/url/{url}/install',
    optionalBody: true,
  )
  Future<chopper.Response> _addonsUrlUrlInstallPost(
      {@Path('url') required String? url});

  ///Uninstalls the add-on with the given ID.
  ///@param addonId addon ID
  ///@param serviceId service ID
  Future<chopper.Response> addonsAddonIdUninstallPost({
    required String? addonId,
    String? serviceId,
  }) {
    return _addonsAddonIdUninstallPost(addonId: addonId, serviceId: serviceId);
  }

  ///Uninstalls the add-on with the given ID.
  ///@param addonId addon ID
  ///@param serviceId service ID
  @Post(
    path: '/addons/{addonId}/uninstall',
    optionalBody: true,
  )
  Future<chopper.Response> _addonsAddonIdUninstallPost({
    @Path('addonId') required String? addonId,
    @Query('serviceId') String? serviceId,
  });

  ///Gets all available channel types.
  ///@param Accept-Language language
  ///@param prefixes filter UIDs by prefix (multiple comma-separated prefixes allowed, for example: 'system,mqtt')
  Future<chopper.Response<List<ChannelTypeDTO>>> channelTypesGet({
    String? acceptLanguage,
    String? prefixes,
  }) {
    generatedMapping.putIfAbsent(
        ChannelTypeDTO, () => ChannelTypeDTO.fromJsonFactory);

    return _channelTypesGet(
        acceptLanguage: acceptLanguage?.toString(), prefixes: prefixes);
  }

  ///Gets all available channel types.
  ///@param Accept-Language language
  ///@param prefixes filter UIDs by prefix (multiple comma-separated prefixes allowed, for example: 'system,mqtt')
  @Get(path: '/channel-types')
  Future<chopper.Response<List<ChannelTypeDTO>>> _channelTypesGet({
    @Header('Accept-Language') String? acceptLanguage,
    @Query('prefixes') String? prefixes,
  });

  ///Gets channel type by UID.
  ///@param channelTypeUID channelTypeUID
  ///@param Accept-Language language
  Future<chopper.Response<ChannelTypeDTO>> channelTypesChannelTypeUIDGet({
    required String? channelTypeUID,
    String? acceptLanguage,
  }) {
    generatedMapping.putIfAbsent(
        ChannelTypeDTO, () => ChannelTypeDTO.fromJsonFactory);

    return _channelTypesChannelTypeUIDGet(
        channelTypeUID: channelTypeUID,
        acceptLanguage: acceptLanguage?.toString());
  }

  ///Gets channel type by UID.
  ///@param channelTypeUID channelTypeUID
  ///@param Accept-Language language
  @Get(path: '/channel-types/{channelTypeUID}')
  Future<chopper.Response<ChannelTypeDTO>> _channelTypesChannelTypeUIDGet({
    @Path('channelTypeUID') required String? channelTypeUID,
    @Header('Accept-Language') String? acceptLanguage,
  });

  ///Gets the item types the given trigger channel type UID can be linked to.
  ///@param channelTypeUID channelTypeUID
  Future<chopper.Response<List<String>>>
      channelTypesChannelTypeUIDLinkableItemTypesGet(
          {required String? channelTypeUID}) {
    return _channelTypesChannelTypeUIDLinkableItemTypesGet(
        channelTypeUID: channelTypeUID);
  }

  ///Gets the item types the given trigger channel type UID can be linked to.
  ///@param channelTypeUID channelTypeUID
  @Get(path: '/channel-types/{channelTypeUID}/linkableItemTypes')
  Future<chopper.Response<List<String>>>
      _channelTypesChannelTypeUIDLinkableItemTypesGet(
          {@Path('channelTypeUID') required String? channelTypeUID});

  ///Gets all available config descriptions.
  ///@param Accept-Language language
  ///@param scheme scheme filter
  Future<chopper.Response<List<ConfigDescriptionDTO>>> configDescriptionsGet({
    String? acceptLanguage,
    String? scheme,
  }) {
    generatedMapping.putIfAbsent(
        ConfigDescriptionDTO, () => ConfigDescriptionDTO.fromJsonFactory);

    return _configDescriptionsGet(
        acceptLanguage: acceptLanguage?.toString(), scheme: scheme);
  }

  ///Gets all available config descriptions.
  ///@param Accept-Language language
  ///@param scheme scheme filter
  @Get(path: '/config-descriptions')
  Future<chopper.Response<List<ConfigDescriptionDTO>>> _configDescriptionsGet({
    @Header('Accept-Language') String? acceptLanguage,
    @Query('scheme') String? scheme,
  });

  ///Gets a config description by URI.
  ///@param Accept-Language language
  ///@param uri uri
  Future<chopper.Response<ConfigDescriptionDTO>> configDescriptionsUriGet({
    String? acceptLanguage,
    required String? uri,
  }) {
    generatedMapping.putIfAbsent(
        ConfigDescriptionDTO, () => ConfigDescriptionDTO.fromJsonFactory);

    return _configDescriptionsUriGet(
        acceptLanguage: acceptLanguage?.toString(), uri: uri);
  }

  ///Gets a config description by URI.
  ///@param Accept-Language language
  ///@param uri uri
  @Get(path: '/config-descriptions/{uri}')
  Future<chopper.Response<ConfigDescriptionDTO>> _configDescriptionsUriGet({
    @Header('Accept-Language') String? acceptLanguage,
    @Path('uri') required String? uri,
  });

  ///Gets all bindings that support discovery.
  Future<chopper.Response<List<String>>> discoveryGet() {
    return _discoveryGet();
  }

  ///Gets all bindings that support discovery.
  @Get(path: '/discovery')
  Future<chopper.Response<List<String>>> _discoveryGet();

  ///Starts asynchronous discovery process for a binding and returns the timeout in seconds of the discovery operation.
  ///@param bindingId bindingId
  Future<chopper.Response<int>> discoveryBindingsBindingIdScanPost(
      {required String? bindingId}) {
    return _discoveryBindingsBindingIdScanPost(bindingId: bindingId);
  }

  ///Starts asynchronous discovery process for a binding and returns the timeout in seconds of the discovery operation.
  ///@param bindingId bindingId
  @Post(
    path: '/discovery/bindings/{bindingId}/scan',
    optionalBody: true,
  )
  Future<chopper.Response<int>> _discoveryBindingsBindingIdScanPost(
      {@Path('bindingId') required String? bindingId});

  ///Approves the discovery result by adding the thing to the registry.
  ///@param Accept-Language language
  ///@param thingUID thingUID
  ///@param newThingId new thing ID
  Future<chopper.Response> inboxThingUIDApprovePost({
    String? acceptLanguage,
    required String? thingUID,
    String? newThingId,
    required String? body,
  }) {
    return _inboxThingUIDApprovePost(
        acceptLanguage: acceptLanguage?.toString(),
        thingUID: thingUID,
        newThingId: newThingId,
        body: body);
  }

  ///Approves the discovery result by adding the thing to the registry.
  ///@param Accept-Language language
  ///@param thingUID thingUID
  ///@param newThingId new thing ID
  @Post(
    path: '/inbox/{thingUID}/approve',
    optionalBody: true,
  )
  Future<chopper.Response> _inboxThingUIDApprovePost({
    @Header('Accept-Language') String? acceptLanguage,
    @Path('thingUID') required String? thingUID,
    @Query('newThingId') String? newThingId,
    @Body() required String? body,
  });

  ///Removes the discovery result from the inbox.
  ///@param thingUID thingUID
  Future<chopper.Response> inboxThingUIDDelete({required String? thingUID}) {
    return _inboxThingUIDDelete(thingUID: thingUID);
  }

  ///Removes the discovery result from the inbox.
  ///@param thingUID thingUID
  @Delete(path: '/inbox/{thingUID}')
  Future<chopper.Response> _inboxThingUIDDelete(
      {@Path('thingUID') required String? thingUID});

  ///Get all discovered things.
  Future<chopper.Response<List<DiscoveryResultDTO>>> inboxGet() {
    generatedMapping.putIfAbsent(
        DiscoveryResultDTO, () => DiscoveryResultDTO.fromJsonFactory);

    return _inboxGet();
  }

  ///Get all discovered things.
  @Get(path: '/inbox')
  Future<chopper.Response<List<DiscoveryResultDTO>>> _inboxGet();

  ///Flags a discovery result as ignored for further processing.
  ///@param thingUID thingUID
  Future<chopper.Response> inboxThingUIDIgnorePost(
      {required String? thingUID}) {
    return _inboxThingUIDIgnorePost(thingUID: thingUID);
  }

  ///Flags a discovery result as ignored for further processing.
  ///@param thingUID thingUID
  @Post(
    path: '/inbox/{thingUID}/ignore',
    optionalBody: true,
  )
  Future<chopper.Response> _inboxThingUIDIgnorePost(
      {@Path('thingUID') required String? thingUID});

  ///Removes ignore flag from a discovery result.
  ///@param thingUID thingUID
  Future<chopper.Response> inboxThingUIDUnignorePost(
      {required String? thingUID}) {
    return _inboxThingUIDUnignorePost(thingUID: thingUID);
  }

  ///Removes ignore flag from a discovery result.
  ///@param thingUID thingUID
  @Post(
    path: '/inbox/{thingUID}/unignore',
    optionalBody: true,
  )
  Future<chopper.Response> _inboxThingUIDUnignorePost(
      {@Path('thingUID') required String? thingUID});

  ///Adds a new member to a group item.
  ///@param itemName item name
  ///@param memberItemName member item name
  Future<chopper.Response> itemsItemNameMembersMemberItemNamePut({
    required String? itemName,
    required String? memberItemName,
  }) {
    return _itemsItemNameMembersMemberItemNamePut(
        itemName: itemName, memberItemName: memberItemName);
  }

  ///Adds a new member to a group item.
  ///@param itemName item name
  ///@param memberItemName member item name
  @Put(
    path: '/items/{itemName}/members/{memberItemName}',
    optionalBody: true,
  )
  Future<chopper.Response> _itemsItemNameMembersMemberItemNamePut({
    @Path('itemName') required String? itemName,
    @Path('memberItemName') required String? memberItemName,
  });

  ///Removes an existing member from a group item.
  ///@param itemName item name
  ///@param memberItemName member item name
  Future<chopper.Response> itemsItemNameMembersMemberItemNameDelete({
    required String? itemName,
    required String? memberItemName,
  }) {
    return _itemsItemNameMembersMemberItemNameDelete(
        itemName: itemName, memberItemName: memberItemName);
  }

  ///Removes an existing member from a group item.
  ///@param itemName item name
  ///@param memberItemName member item name
  @Delete(path: '/items/{itemName}/members/{memberItemName}')
  Future<chopper.Response> _itemsItemNameMembersMemberItemNameDelete({
    @Path('itemName') required String? itemName,
    @Path('memberItemName') required String? memberItemName,
  });

  ///Adds metadata to an item.
  ///@param itemname item name
  ///@param namespace namespace
  Future<chopper.Response> itemsItemnameMetadataNamespacePut({
    required String? itemname,
    required String? namespace,
    required MetadataDTO? body,
  }) {
    return _itemsItemnameMetadataNamespacePut(
        itemname: itemname, namespace: namespace, body: body);
  }

  ///Adds metadata to an item.
  ///@param itemname item name
  ///@param namespace namespace
  @Put(
    path: '/items/{itemname}/metadata/{namespace}',
    optionalBody: true,
  )
  Future<chopper.Response> _itemsItemnameMetadataNamespacePut({
    @Path('itemname') required String? itemname,
    @Path('namespace') required String? namespace,
    @Body() required MetadataDTO? body,
  });

  ///Removes metadata from an item.
  ///@param itemname item name
  ///@param namespace namespace
  Future<chopper.Response> itemsItemnameMetadataNamespaceDelete({
    required String? itemname,
    required String? namespace,
  }) {
    return _itemsItemnameMetadataNamespaceDelete(
        itemname: itemname, namespace: namespace);
  }

  ///Removes metadata from an item.
  ///@param itemname item name
  ///@param namespace namespace
  @Delete(path: '/items/{itemname}/metadata/{namespace}')
  Future<chopper.Response> _itemsItemnameMetadataNamespaceDelete({
    @Path('itemname') required String? itemname,
    @Path('namespace') required String? namespace,
  });

  ///Adds a tag to an item.
  ///@param itemname item name
  ///@param tag tag
  Future<chopper.Response> itemsItemnameTagsTagPut({
    required String? itemname,
    required String? tag,
  }) {
    return _itemsItemnameTagsTagPut(itemname: itemname, tag: tag);
  }

  ///Adds a tag to an item.
  ///@param itemname item name
  ///@param tag tag
  @Put(
    path: '/items/{itemname}/tags/{tag}',
    optionalBody: true,
  )
  Future<chopper.Response> _itemsItemnameTagsTagPut({
    @Path('itemname') required String? itemname,
    @Path('tag') required String? tag,
  });

  ///Removes a tag from an item.
  ///@param itemname item name
  ///@param tag tag
  Future<chopper.Response> itemsItemnameTagsTagDelete({
    required String? itemname,
    required String? tag,
  }) {
    return _itemsItemnameTagsTagDelete(itemname: itemname, tag: tag);
  }

  ///Removes a tag from an item.
  ///@param itemname item name
  ///@param tag tag
  @Delete(path: '/items/{itemname}/tags/{tag}')
  Future<chopper.Response> _itemsItemnameTagsTagDelete({
    @Path('itemname') required String? itemname,
    @Path('tag') required String? tag,
  });

  ///Gets a single item.
  ///@param Accept-Language language
  ///@param metadata metadata selector - a comma separated list or a regular expression (returns all if no value given)
  ///@param recursive get member items if the item is a group item
  ///@param itemname item name
  Future<chopper.Response<EnrichedItemDTO>> itemsItemnameGet({
    String? acceptLanguage,
    String? metadata,
    bool? recursive,
    required String? itemname,
  }) {
    generatedMapping.putIfAbsent(
        EnrichedItemDTO, () => EnrichedItemDTO.fromJsonFactory);

    return _itemsItemnameGet(
        acceptLanguage: acceptLanguage?.toString(),
        metadata: metadata,
        recursive: recursive,
        itemname: itemname);
  }

  ///Gets a single item.
  ///@param Accept-Language language
  ///@param metadata metadata selector - a comma separated list or a regular expression (returns all if no value given)
  ///@param recursive get member items if the item is a group item
  ///@param itemname item name
  @Get(path: '/items/{itemname}')
  Future<chopper.Response<EnrichedItemDTO>> _itemsItemnameGet({
    @Header('Accept-Language') String? acceptLanguage,
    @Query('metadata') String? metadata,
    @Query('recursive') bool? recursive,
    @Path('itemname') required String? itemname,
  });

  ///Adds a new item to the registry or updates the existing item.
  ///@param Accept-Language language
  ///@param itemname item name
  Future<chopper.Response<EnrichedItemDTO>> itemsItemnamePut({
    String? acceptLanguage,
    required String? itemname,
    required GroupItemDTO? body,
  }) {
    generatedMapping.putIfAbsent(
        EnrichedItemDTO, () => EnrichedItemDTO.fromJsonFactory);

    return _itemsItemnamePut(
        acceptLanguage: acceptLanguage?.toString(),
        itemname: itemname,
        body: body);
  }

  ///Adds a new item to the registry or updates the existing item.
  ///@param Accept-Language language
  ///@param itemname item name
  @Put(
    path: '/items/{itemname}',
    optionalBody: true,
  )
  Future<chopper.Response<EnrichedItemDTO>> _itemsItemnamePut({
    @Header('Accept-Language') String? acceptLanguage,
    @Path('itemname') required String? itemname,
    @Body() required GroupItemDTO? body,
  });

  ///Sends a command to an item.
  ///@param itemname item name
  Future<chopper.Response> itemsItemnamePost({
    required String? itemname,
    required String? body,
  }) {
    return _itemsItemnamePost(itemname: itemname, body: body);
  }

  ///Sends a command to an item.
  ///@param itemname item name
  @Post(
    path: '/items/{itemname}',
    optionalBody: true,
  )
  Future<chopper.Response> _itemsItemnamePost({
    @Path('itemname') required String? itemname,
    @Body() required String? body,
  });

  ///Removes an item from the registry.
  ///@param itemname item name
  Future<chopper.Response> itemsItemnameDelete({required String? itemname}) {
    return _itemsItemnameDelete(itemname: itemname);
  }

  ///Removes an item from the registry.
  ///@param itemname item name
  @Delete(path: '/items/{itemname}')
  Future<chopper.Response> _itemsItemnameDelete(
      {@Path('itemname') required String? itemname});

  ///Get all available items.
  ///@param Accept-Language language
  ///@param type item type filter
  ///@param tags item tag filter
  ///@param metadata metadata selector - a comma separated list or a regular expression (returns all if no value given)
  ///@param recursive get member items recursively
  ///@param fields limit output to the given fields (comma separated)
  ///@param staticDataOnly provides a cacheable list of values not expected to change regularly and checks the If-Modified-Since header, all other parameters are ignored except "metadata"
  Future<chopper.Response<List<EnrichedItemDTO>>> itemsGet({
    String? acceptLanguage,
    String? type,
    String? tags,
    String? metadata,
    bool? recursive,
    String? fields,
    bool? staticDataOnly,
  }) {
    generatedMapping.putIfAbsent(
        EnrichedItemDTO, () => EnrichedItemDTO.fromJsonFactory);

    return _itemsGet(
        acceptLanguage: acceptLanguage?.toString(),
        type: type,
        tags: tags,
        metadata: metadata,
        recursive: recursive,
        fields: fields,
        staticDataOnly: staticDataOnly);
  }

  ///Get all available items.
  ///@param Accept-Language language
  ///@param type item type filter
  ///@param tags item tag filter
  ///@param metadata metadata selector - a comma separated list or a regular expression (returns all if no value given)
  ///@param recursive get member items recursively
  ///@param fields limit output to the given fields (comma separated)
  ///@param staticDataOnly provides a cacheable list of values not expected to change regularly and checks the If-Modified-Since header, all other parameters are ignored except "metadata"
  @Get(path: '/items')
  Future<chopper.Response<List<EnrichedItemDTO>>> _itemsGet({
    @Header('Accept-Language') String? acceptLanguage,
    @Query('type') String? type,
    @Query('tags') String? tags,
    @Query('metadata') String? metadata,
    @Query('recursive') bool? recursive,
    @Query('fields') String? fields,
    @Query('staticDataOnly') bool? staticDataOnly,
  });

  ///Adds a list of items to the registry or updates the existing items.
  Future<chopper.Response<String>> itemsPut(
      {required List<GroupItemDTO>? body}) {
    return _itemsPut(body: body);
  }

  ///Adds a list of items to the registry or updates the existing items.
  @Put(
    path: '/items',
    optionalBody: true,
  )
  Future<chopper.Response<String>> _itemsPut(
      {@Body() required List<GroupItemDTO>? body});

  ///Gets the state of an item.
  ///@param itemname item name
  Future<chopper.Response<String>> itemsItemnameStateGet(
      {required String? itemname}) {
    return _itemsItemnameStateGet(itemname: itemname);
  }

  ///Gets the state of an item.
  ///@param itemname item name
  @Get(path: '/items/{itemname}/state')
  Future<chopper.Response<String>> _itemsItemnameStateGet(
      {@Path('itemname') required String? itemname});

  ///Updates the state of an item.
  ///@param Accept-Language language
  ///@param itemname item name
  Future<chopper.Response> itemsItemnameStatePut({
    String? acceptLanguage,
    required String? itemname,
    required String? body,
  }) {
    return _itemsItemnameStatePut(
        acceptLanguage: acceptLanguage?.toString(),
        itemname: itemname,
        body: body);
  }

  ///Updates the state of an item.
  ///@param Accept-Language language
  ///@param itemname item name
  @Put(
    path: '/items/{itemname}/state',
    optionalBody: true,
  )
  Future<chopper.Response> _itemsItemnameStatePut({
    @Header('Accept-Language') String? acceptLanguage,
    @Path('itemname') required String? itemname,
    @Body() required String? body,
  });

  ///Gets the namespace of an item.
  ///@param itemname item name
  ///@param Accept-Language language
  Future<chopper.Response<String>> itemsItemnameMetadataNamespacesGet({
    required String? itemname,
    String? acceptLanguage,
  }) {
    return _itemsItemnameMetadataNamespacesGet(
        itemname: itemname, acceptLanguage: acceptLanguage?.toString());
  }

  ///Gets the namespace of an item.
  ///@param itemname item name
  ///@param Accept-Language language
  @Get(path: '/items/{itemname}/metadata/namespaces')
  Future<chopper.Response<String>> _itemsItemnameMetadataNamespacesGet({
    @Path('itemname') required String? itemname,
    @Header('Accept-Language') String? acceptLanguage,
  });

  ///Gets the item which defines the requested semantics of an item.
  ///@param Accept-Language language
  ///@param itemName item name
  ///@param semanticClass semantic class
  Future<chopper.Response> itemsItemNameSemanticSemanticClassGet({
    String? acceptLanguage,
    required String? itemName,
    required String? semanticClass,
  }) {
    return _itemsItemNameSemanticSemanticClassGet(
        acceptLanguage: acceptLanguage?.toString(),
        itemName: itemName,
        semanticClass: semanticClass);
  }

  ///Gets the item which defines the requested semantics of an item.
  ///@param Accept-Language language
  ///@param itemName item name
  ///@param semanticClass semantic class
  @Get(path: '/items/{itemName}/semantic/{semanticClass}')
  Future<chopper.Response> _itemsItemNameSemanticSemanticClassGet({
    @Header('Accept-Language') String? acceptLanguage,
    @Path('itemName') required String? itemName,
    @Path('semanticClass') required String? semanticClass,
  });

  ///Remove unused/orphaned metadata.
  Future<chopper.Response> itemsMetadataPurgePost() {
    return _itemsMetadataPurgePost();
  }

  ///Remove unused/orphaned metadata.
  @Post(
    path: '/items/metadata/purge',
    optionalBody: true,
  )
  Future<chopper.Response> _itemsMetadataPurgePost();

  ///Gets all available links.
  ///@param channelUID filter by channel UID
  ///@param itemName filter by item name
  Future<chopper.Response<List<EnrichedItemChannelLinkDTO>>> linksGet({
    String? channelUID,
    String? itemName,
  }) {
    generatedMapping.putIfAbsent(EnrichedItemChannelLinkDTO,
        () => EnrichedItemChannelLinkDTO.fromJsonFactory);

    return _linksGet(channelUID: channelUID, itemName: itemName);
  }

  ///Gets all available links.
  ///@param channelUID filter by channel UID
  ///@param itemName filter by item name
  @Get(path: '/links')
  Future<chopper.Response<List<EnrichedItemChannelLinkDTO>>> _linksGet({
    @Query('channelUID') String? channelUID,
    @Query('itemName') String? itemName,
  });

  ///Retrieves an individual link.
  ///@param itemName item name
  ///@param channelUID channel UID
  Future<chopper.Response<EnrichedItemChannelLinkDTO>>
      linksItemNameChannelUIDGet({
    required String? itemName,
    required String? channelUID,
  }) {
    generatedMapping.putIfAbsent(EnrichedItemChannelLinkDTO,
        () => EnrichedItemChannelLinkDTO.fromJsonFactory);

    return _linksItemNameChannelUIDGet(
        itemName: itemName, channelUID: channelUID);
  }

  ///Retrieves an individual link.
  ///@param itemName item name
  ///@param channelUID channel UID
  @Get(path: '/links/{itemName}/{channelUID}')
  Future<chopper.Response<EnrichedItemChannelLinkDTO>>
      _linksItemNameChannelUIDGet({
    @Path('itemName') required String? itemName,
    @Path('channelUID') required String? channelUID,
  });

  ///Links an item to a channel.
  ///@param itemName itemName
  ///@param channelUID channelUID
  Future<chopper.Response> linksItemNameChannelUIDPut({
    required String? itemName,
    required String? channelUID,
    required ItemChannelLinkDTO? body,
  }) {
    return _linksItemNameChannelUIDPut(
        itemName: itemName, channelUID: channelUID, body: body);
  }

  ///Links an item to a channel.
  ///@param itemName itemName
  ///@param channelUID channelUID
  @Put(
    path: '/links/{itemName}/{channelUID}',
    optionalBody: true,
  )
  Future<chopper.Response> _linksItemNameChannelUIDPut({
    @Path('itemName') required String? itemName,
    @Path('channelUID') required String? channelUID,
    @Body() required ItemChannelLinkDTO? body,
  });

  ///Unlinks an item from a channel.
  ///@param itemName itemName
  ///@param channelUID channelUID
  Future<chopper.Response> linksItemNameChannelUIDDelete({
    required String? itemName,
    required String? channelUID,
  }) {
    return _linksItemNameChannelUIDDelete(
        itemName: itemName, channelUID: channelUID);
  }

  ///Unlinks an item from a channel.
  ///@param itemName itemName
  ///@param channelUID channelUID
  @Delete(path: '/links/{itemName}/{channelUID}')
  Future<chopper.Response> _linksItemNameChannelUIDDelete({
    @Path('itemName') required String? itemName,
    @Path('channelUID') required String? channelUID,
  });

  ///Remove unused/orphaned links.
  Future<chopper.Response> linksPurgePost() {
    return _linksPurgePost();
  }

  ///Remove unused/orphaned links.
  @Post(
    path: '/links/purge',
    optionalBody: true,
  )
  Future<chopper.Response> _linksPurgePost();

  ///Delete all links that refer to an item or thing.
  ///@param object item name or thing UID
  Future<chopper.Response> linksObjectDelete({required String? object}) {
    return _linksObjectDelete(object: object);
  }

  ///Delete all links that refer to an item or thing.
  ///@param object item name or thing UID
  @Delete(path: '/links/{object}')
  Future<chopper.Response> _linksObjectDelete(
      {@Path('object') required String? object});

  ///Gets a persistence service configuration.
  ///@param serviceId Id of the persistence service.
  Future<chopper.Response<PersistenceServiceConfigurationDTO>>
      persistenceServiceIdGet({required String? serviceId}) {
    generatedMapping.putIfAbsent(PersistenceServiceConfigurationDTO,
        () => PersistenceServiceConfigurationDTO.fromJsonFactory);

    return _persistenceServiceIdGet(serviceId: serviceId);
  }

  ///Gets a persistence service configuration.
  ///@param serviceId Id of the persistence service.
  @Get(path: '/persistence/{serviceId}')
  Future<chopper.Response<PersistenceServiceConfigurationDTO>>
      _persistenceServiceIdGet({@Path('serviceId') required String? serviceId});

  ///Sets a persistence service configuration.
  ///@param serviceId Id of the persistence service.
  Future<chopper.Response<PersistenceServiceConfigurationDTO>>
      persistenceServiceIdPut({
    required String? serviceId,
    required PersistenceServiceConfigurationDTO? body,
  }) {
    generatedMapping.putIfAbsent(PersistenceServiceConfigurationDTO,
        () => PersistenceServiceConfigurationDTO.fromJsonFactory);

    return _persistenceServiceIdPut(serviceId: serviceId, body: body);
  }

  ///Sets a persistence service configuration.
  ///@param serviceId Id of the persistence service.
  @Put(
    path: '/persistence/{serviceId}',
    optionalBody: true,
  )
  Future<chopper.Response<PersistenceServiceConfigurationDTO>>
      _persistenceServiceIdPut({
    @Path('serviceId') required String? serviceId,
    @Body() required PersistenceServiceConfigurationDTO? body,
  });

  ///Deletes a persistence service configuration.
  ///@param serviceId Id of the persistence service.
  Future<chopper.Response> persistenceServiceIdDelete(
      {required String? serviceId}) {
    return _persistenceServiceIdDelete(serviceId: serviceId);
  }

  ///Deletes a persistence service configuration.
  ///@param serviceId Id of the persistence service.
  @Delete(path: '/persistence/{serviceId}')
  Future<chopper.Response> _persistenceServiceIdDelete(
      {@Path('serviceId') required String? serviceId});

  ///Gets item persistence data from the persistence service.
  ///@param serviceId Id of the persistence service. If not provided the default service will be used
  ///@param itemname The item name
  ///@param starttime Start time of the data to return. Will default to 1 day before endtime. [yyyy-MM-dd'T'HH:mm:ss.SSSZ]
  ///@param endtime End time of the data to return. Will default to current time. [yyyy-MM-dd'T'HH:mm:ss.SSSZ]
  ///@param page Page number of data to return. This parameter will enable paging.
  ///@param pagelength The length of each page.
  ///@param boundary Gets one value before and after the requested period.
  Future<chopper.Response<ItemHistoryDTO>> persistenceItemsItemnameGet({
    String? serviceId,
    required String? itemname,
    String? starttime,
    String? endtime,
    int? page,
    int? pagelength,
    bool? boundary,
  }) {
    generatedMapping.putIfAbsent(
        ItemHistoryDTO, () => ItemHistoryDTO.fromJsonFactory);

    return _persistenceItemsItemnameGet(
        serviceId: serviceId,
        itemname: itemname,
        starttime: starttime,
        endtime: endtime,
        page: page,
        pagelength: pagelength,
        boundary: boundary);
  }

  ///Gets item persistence data from the persistence service.
  ///@param serviceId Id of the persistence service. If not provided the default service will be used
  ///@param itemname The item name
  ///@param starttime Start time of the data to return. Will default to 1 day before endtime. [yyyy-MM-dd'T'HH:mm:ss.SSSZ]
  ///@param endtime End time of the data to return. Will default to current time. [yyyy-MM-dd'T'HH:mm:ss.SSSZ]
  ///@param page Page number of data to return. This parameter will enable paging.
  ///@param pagelength The length of each page.
  ///@param boundary Gets one value before and after the requested period.
  @Get(path: '/persistence/items/{itemname}')
  Future<chopper.Response<ItemHistoryDTO>> _persistenceItemsItemnameGet({
    @Query('serviceId') String? serviceId,
    @Path('itemname') required String? itemname,
    @Query('starttime') String? starttime,
    @Query('endtime') String? endtime,
    @Query('page') int? page,
    @Query('pagelength') int? pagelength,
    @Query('boundary') bool? boundary,
  });

  ///Stores item persistence data into the persistence service.
  ///@param serviceId Id of the persistence service. If not provided the default service will be used
  ///@param itemname The item name.
  ///@param time Time of the data to be stored. Will default to current time. [yyyy-MM-dd'T'HH:mm:ss.SSSZ]
  ///@param state The state to store.
  Future<chopper.Response> persistenceItemsItemnamePut({
    String? serviceId,
    required String? itemname,
    required String? time,
    required String? state,
  }) {
    return _persistenceItemsItemnamePut(
        serviceId: serviceId, itemname: itemname, time: time, state: state);
  }

  ///Stores item persistence data into the persistence service.
  ///@param serviceId Id of the persistence service. If not provided the default service will be used
  ///@param itemname The item name.
  ///@param time Time of the data to be stored. Will default to current time. [yyyy-MM-dd'T'HH:mm:ss.SSSZ]
  ///@param state The state to store.
  @Put(
    path: '/persistence/items/{itemname}',
    optionalBody: true,
  )
  Future<chopper.Response> _persistenceItemsItemnamePut({
    @Query('serviceId') String? serviceId,
    @Path('itemname') required String? itemname,
    @Query('time') required String? time,
    @Query('state') required String? state,
  });

  ///Deletes item persistence data from a specific persistence service in a given time range.
  ///@param serviceId Id of the persistence service.
  ///@param itemname The item name.
  ///@param starttime Start of the time range to be deleted. [yyyy-MM-dd'T'HH:mm:ss.SSSZ]
  ///@param endtime End of the time range to be deleted. [yyyy-MM-dd'T'HH:mm:ss.SSSZ]
  Future<chopper.Response<List<String>>> persistenceItemsItemnameDelete({
    required String? serviceId,
    required String? itemname,
    required String? starttime,
    required String? endtime,
  }) {
    return _persistenceItemsItemnameDelete(
        serviceId: serviceId,
        itemname: itemname,
        starttime: starttime,
        endtime: endtime);
  }

  ///Deletes item persistence data from a specific persistence service in a given time range.
  ///@param serviceId Id of the persistence service.
  ///@param itemname The item name.
  ///@param starttime Start of the time range to be deleted. [yyyy-MM-dd'T'HH:mm:ss.SSSZ]
  ///@param endtime End of the time range to be deleted. [yyyy-MM-dd'T'HH:mm:ss.SSSZ]
  @Delete(path: '/persistence/items/{itemname}')
  Future<chopper.Response<List<String>>> _persistenceItemsItemnameDelete({
    @Query('serviceId') required String? serviceId,
    @Path('itemname') required String? itemname,
    @Query('starttime') required String? starttime,
    @Query('endtime') required String? endtime,
  });

  ///Gets a list of items available via a specific persistence service.
  ///@param serviceId Id of the persistence service. If not provided the default service will be used
  Future<chopper.Response<List<PersistenceItemInfo>>> persistenceItemsGet(
      {String? serviceId}) {
    generatedMapping.putIfAbsent(
        PersistenceItemInfo, () => PersistenceItemInfo.fromJsonFactory);

    return _persistenceItemsGet(serviceId: serviceId);
  }

  ///Gets a list of items available via a specific persistence service.
  ///@param serviceId Id of the persistence service. If not provided the default service will be used
  @Get(path: '/persistence/items')
  Future<chopper.Response<List<PersistenceItemInfo>>> _persistenceItemsGet(
      {@Query('serviceId') String? serviceId});

  ///Gets a list of persistence services.
  ///@param Accept-Language language
  Future<chopper.Response<List<PersistenceServiceDTO>>> persistenceGet(
      {String? acceptLanguage}) {
    generatedMapping.putIfAbsent(
        PersistenceServiceDTO, () => PersistenceServiceDTO.fromJsonFactory);

    return _persistenceGet(acceptLanguage: acceptLanguage?.toString());
  }

  ///Gets a list of persistence services.
  ///@param Accept-Language language
  @Get(path: '/persistence')
  Future<chopper.Response<List<PersistenceServiceDTO>>> _persistenceGet(
      {@Header('Accept-Language') String? acceptLanguage});

  ///Gets all available profile types.
  ///@param Accept-Language language
  ///@param channelTypeUID channel type filter
  ///@param itemType item type filter
  Future<chopper.Response<List<ProfileTypeDTO>>> profileTypesGet({
    String? acceptLanguage,
    String? channelTypeUID,
    String? itemType,
  }) {
    generatedMapping.putIfAbsent(
        ProfileTypeDTO, () => ProfileTypeDTO.fromJsonFactory);

    return _profileTypesGet(
        acceptLanguage: acceptLanguage?.toString(),
        channelTypeUID: channelTypeUID,
        itemType: itemType);
  }

  ///Gets all available profile types.
  ///@param Accept-Language language
  ///@param channelTypeUID channel type filter
  ///@param itemType item type filter
  @Get(path: '/profile-types')
  Future<chopper.Response<List<ProfileTypeDTO>>> _profileTypesGet({
    @Header('Accept-Language') String? acceptLanguage,
    @Query('channelTypeUID') String? channelTypeUID,
    @Query('itemType') String? itemType,
  });

  ///Get service configuration for given service ID.
  ///@param serviceId service ID
  Future<chopper.Response<String>> servicesServiceIdConfigGet(
      {required String? serviceId}) {
    return _servicesServiceIdConfigGet(serviceId: serviceId);
  }

  ///Get service configuration for given service ID.
  ///@param serviceId service ID
  @Get(path: '/services/{serviceId}/config')
  Future<chopper.Response<String>> _servicesServiceIdConfigGet(
      {@Path('serviceId') required String? serviceId});

  ///Updates a service configuration for given service ID and returns the old configuration.
  ///@param Accept-Language language
  ///@param serviceId service ID
  Future<chopper.Response<String>> servicesServiceIdConfigPut({
    String? acceptLanguage,
    required String? serviceId,
    required Object? body,
  }) {
    return _servicesServiceIdConfigPut(
        acceptLanguage: acceptLanguage?.toString(),
        serviceId: serviceId,
        body: body);
  }

  ///Updates a service configuration for given service ID and returns the old configuration.
  ///@param Accept-Language language
  ///@param serviceId service ID
  @Put(
    path: '/services/{serviceId}/config',
    optionalBody: true,
  )
  Future<chopper.Response<String>> _servicesServiceIdConfigPut({
    @Header('Accept-Language') String? acceptLanguage,
    @Path('serviceId') required String? serviceId,
    @Body() required Object? body,
  });

  ///Deletes a service configuration for given service ID and returns the old configuration.
  ///@param serviceId service ID
  Future<chopper.Response<String>> servicesServiceIdConfigDelete(
      {required String? serviceId}) {
    return _servicesServiceIdConfigDelete(serviceId: serviceId);
  }

  ///Deletes a service configuration for given service ID and returns the old configuration.
  ///@param serviceId service ID
  @Delete(path: '/services/{serviceId}/config')
  Future<chopper.Response<String>> _servicesServiceIdConfigDelete(
      {@Path('serviceId') required String? serviceId});

  ///Get all configurable services.
  ///@param Accept-Language language
  Future<chopper.Response<List<ConfigurableServiceDTO>>> servicesGet(
      {String? acceptLanguage}) {
    generatedMapping.putIfAbsent(
        ConfigurableServiceDTO, () => ConfigurableServiceDTO.fromJsonFactory);

    return _servicesGet(acceptLanguage: acceptLanguage?.toString());
  }

  ///Get all configurable services.
  ///@param Accept-Language language
  @Get(path: '/services')
  Future<chopper.Response<List<ConfigurableServiceDTO>>> _servicesGet(
      {@Header('Accept-Language') String? acceptLanguage});

  ///Get configurable service for given service ID.
  ///@param Accept-Language language
  ///@param serviceId service ID
  Future<chopper.Response<ConfigurableServiceDTO>> servicesServiceIdGet({
    String? acceptLanguage,
    required String? serviceId,
  }) {
    generatedMapping.putIfAbsent(
        ConfigurableServiceDTO, () => ConfigurableServiceDTO.fromJsonFactory);

    return _servicesServiceIdGet(
        acceptLanguage: acceptLanguage?.toString(), serviceId: serviceId);
  }

  ///Get configurable service for given service ID.
  ///@param Accept-Language language
  ///@param serviceId service ID
  @Get(path: '/services/{serviceId}')
  Future<chopper.Response<ConfigurableServiceDTO>> _servicesServiceIdGet({
    @Header('Accept-Language') String? acceptLanguage,
    @Path('serviceId') required String? serviceId,
  });

  ///Get existing multiple context service configurations for the given factory PID.
  ///@param Accept-Language language
  ///@param serviceId service ID
  Future<chopper.Response<List<ConfigurableServiceDTO>>>
      servicesServiceIdContextsGet({
    String? acceptLanguage,
    required String? serviceId,
  }) {
    generatedMapping.putIfAbsent(
        ConfigurableServiceDTO, () => ConfigurableServiceDTO.fromJsonFactory);

    return _servicesServiceIdContextsGet(
        acceptLanguage: acceptLanguage?.toString(), serviceId: serviceId);
  }

  ///Get existing multiple context service configurations for the given factory PID.
  ///@param Accept-Language language
  ///@param serviceId service ID
  @Get(path: '/services/{serviceId}/contexts')
  Future<chopper.Response<List<ConfigurableServiceDTO>>>
      _servicesServiceIdContextsGet({
    @Header('Accept-Language') String? acceptLanguage,
    @Path('serviceId') required String? serviceId,
  });

  ///Get all available semantic tags.
  ///@param Accept-Language language
  Future<chopper.Response<List<EnrichedSemanticTagDTO>>> tagsGet(
      {String? acceptLanguage}) {
    generatedMapping.putIfAbsent(
        EnrichedSemanticTagDTO, () => EnrichedSemanticTagDTO.fromJsonFactory);

    return _tagsGet(acceptLanguage: acceptLanguage?.toString());
  }

  ///Get all available semantic tags.
  ///@param Accept-Language language
  @Get(path: '/tags')
  Future<chopper.Response<List<EnrichedSemanticTagDTO>>> _tagsGet(
      {@Header('Accept-Language') String? acceptLanguage});

  ///Creates a new semantic tag and adds it to the registry.
  ///@param Accept-Language language
  Future<chopper.Response<EnrichedSemanticTagDTO>> tagsPost({
    String? acceptLanguage,
    required EnrichedSemanticTagDTO? body,
  }) {
    generatedMapping.putIfAbsent(
        EnrichedSemanticTagDTO, () => EnrichedSemanticTagDTO.fromJsonFactory);

    return _tagsPost(acceptLanguage: acceptLanguage?.toString(), body: body);
  }

  ///Creates a new semantic tag and adds it to the registry.
  ///@param Accept-Language language
  @Post(
    path: '/tags',
    optionalBody: true,
  )
  Future<chopper.Response<EnrichedSemanticTagDTO>> _tagsPost({
    @Header('Accept-Language') String? acceptLanguage,
    @Body() required EnrichedSemanticTagDTO? body,
  });

  ///Gets a semantic tag and its sub tags.
  ///@param Accept-Language language
  ///@param tagId tag id
  Future<chopper.Response<List<EnrichedSemanticTagDTO>>> tagsTagIdGet({
    String? acceptLanguage,
    required String? tagId,
  }) {
    generatedMapping.putIfAbsent(
        EnrichedSemanticTagDTO, () => EnrichedSemanticTagDTO.fromJsonFactory);

    return _tagsTagIdGet(
        acceptLanguage: acceptLanguage?.toString(), tagId: tagId);
  }

  ///Gets a semantic tag and its sub tags.
  ///@param Accept-Language language
  ///@param tagId tag id
  @Get(path: '/tags/{tagId}')
  Future<chopper.Response<List<EnrichedSemanticTagDTO>>> _tagsTagIdGet({
    @Header('Accept-Language') String? acceptLanguage,
    @Path('tagId') required String? tagId,
  });

  ///Updates a semantic tag.
  ///@param Accept-Language language
  ///@param tagId tag id
  Future<chopper.Response<EnrichedSemanticTagDTO>> tagsTagIdPut({
    String? acceptLanguage,
    required String? tagId,
    required EnrichedSemanticTagDTO? body,
  }) {
    generatedMapping.putIfAbsent(
        EnrichedSemanticTagDTO, () => EnrichedSemanticTagDTO.fromJsonFactory);

    return _tagsTagIdPut(
        acceptLanguage: acceptLanguage?.toString(), tagId: tagId, body: body);
  }

  ///Updates a semantic tag.
  ///@param Accept-Language language
  ///@param tagId tag id
  @Put(
    path: '/tags/{tagId}',
    optionalBody: true,
  )
  Future<chopper.Response<EnrichedSemanticTagDTO>> _tagsTagIdPut({
    @Header('Accept-Language') String? acceptLanguage,
    @Path('tagId') required String? tagId,
    @Body() required EnrichedSemanticTagDTO? body,
  });

  ///Removes a semantic tag and its sub tags from the registry.
  ///@param Accept-Language language
  ///@param tagId tag id
  Future<chopper.Response> tagsTagIdDelete({
    String? acceptLanguage,
    required String? tagId,
  }) {
    return _tagsTagIdDelete(
        acceptLanguage: acceptLanguage?.toString(), tagId: tagId);
  }

  ///Removes a semantic tag and its sub tags from the registry.
  ///@param Accept-Language language
  ///@param tagId tag id
  @Delete(path: '/tags/{tagId}')
  Future<chopper.Response> _tagsTagIdDelete({
    @Header('Accept-Language') String? acceptLanguage,
    @Path('tagId') required String? tagId,
  });

  ///Get all available things.
  ///@param Accept-Language language
  ///@param summary summary fields only
  ///@param staticDataOnly provides a cacheable list of values not expected to change regularly and checks the If-Modified-Since header
  Future<chopper.Response<List<EnrichedThingDTO>>> thingsGet({
    String? acceptLanguage,
    bool? summary,
    bool? staticDataOnly,
  }) {
    generatedMapping.putIfAbsent(
        EnrichedThingDTO, () => EnrichedThingDTO.fromJsonFactory);

    return _thingsGet(
        acceptLanguage: acceptLanguage?.toString(),
        summary: summary,
        staticDataOnly: staticDataOnly);
  }

  ///Get all available things.
  ///@param Accept-Language language
  ///@param summary summary fields only
  ///@param staticDataOnly provides a cacheable list of values not expected to change regularly and checks the If-Modified-Since header
  @Get(path: '/things')
  Future<chopper.Response<List<EnrichedThingDTO>>> _thingsGet({
    @Header('Accept-Language') String? acceptLanguage,
    @Query('summary') bool? summary,
    @Query('staticDataOnly') bool? staticDataOnly,
  });

  ///Creates a new thing and adds it to the registry.
  ///@param Accept-Language language
  Future<chopper.Response<EnrichedThingDTO>> thingsPost({
    String? acceptLanguage,
    required ThingDTO? body,
  }) {
    generatedMapping.putIfAbsent(
        EnrichedThingDTO, () => EnrichedThingDTO.fromJsonFactory);

    return _thingsPost(acceptLanguage: acceptLanguage?.toString(), body: body);
  }

  ///Creates a new thing and adds it to the registry.
  ///@param Accept-Language language
  @Post(
    path: '/things',
    optionalBody: true,
  )
  Future<chopper.Response<EnrichedThingDTO>> _thingsPost({
    @Header('Accept-Language') String? acceptLanguage,
    @Body() required ThingDTO? body,
  });

  ///Gets thing by UID.
  ///@param Accept-Language language
  ///@param thingUID thingUID
  Future<chopper.Response<EnrichedThingDTO>> thingsThingUIDGet({
    String? acceptLanguage,
    required String? thingUID,
  }) {
    generatedMapping.putIfAbsent(
        EnrichedThingDTO, () => EnrichedThingDTO.fromJsonFactory);

    return _thingsThingUIDGet(
        acceptLanguage: acceptLanguage?.toString(), thingUID: thingUID);
  }

  ///Gets thing by UID.
  ///@param Accept-Language language
  ///@param thingUID thingUID
  @Get(path: '/things/{thingUID}')
  Future<chopper.Response<EnrichedThingDTO>> _thingsThingUIDGet({
    @Header('Accept-Language') String? acceptLanguage,
    @Path('thingUID') required String? thingUID,
  });

  ///Updates a thing.
  ///@param Accept-Language language
  ///@param thingUID thingUID
  Future<chopper.Response<EnrichedThingDTO>> thingsThingUIDPut({
    String? acceptLanguage,
    required String? thingUID,
    required ThingDTO? body,
  }) {
    generatedMapping.putIfAbsent(
        EnrichedThingDTO, () => EnrichedThingDTO.fromJsonFactory);

    return _thingsThingUIDPut(
        acceptLanguage: acceptLanguage?.toString(),
        thingUID: thingUID,
        body: body);
  }

  ///Updates a thing.
  ///@param Accept-Language language
  ///@param thingUID thingUID
  @Put(
    path: '/things/{thingUID}',
    optionalBody: true,
  )
  Future<chopper.Response<EnrichedThingDTO>> _thingsThingUIDPut({
    @Header('Accept-Language') String? acceptLanguage,
    @Path('thingUID') required String? thingUID,
    @Body() required ThingDTO? body,
  });

  ///Removes a thing from the registry. Set 'force' to __true__ if you want the thing to be removed immediately.
  ///@param Accept-Language language
  ///@param thingUID thingUID
  ///@param force force
  Future<chopper.Response> thingsThingUIDDelete({
    String? acceptLanguage,
    required String? thingUID,
    bool? force,
  }) {
    return _thingsThingUIDDelete(
        acceptLanguage: acceptLanguage?.toString(),
        thingUID: thingUID,
        force: force);
  }

  ///Removes a thing from the registry. Set 'force' to __true__ if you want the thing to be removed immediately.
  ///@param Accept-Language language
  ///@param thingUID thingUID
  ///@param force force
  @Delete(path: '/things/{thingUID}')
  Future<chopper.Response> _thingsThingUIDDelete({
    @Header('Accept-Language') String? acceptLanguage,
    @Path('thingUID') required String? thingUID,
    @Query('force') bool? force,
  });

  ///Gets thing config status.
  ///@param Accept-Language language
  ///@param thingUID thing
  Future<chopper.Response<List<ConfigStatusMessage>>>
      thingsThingUIDConfigStatusGet({
    String? acceptLanguage,
    required String? thingUID,
  }) {
    generatedMapping.putIfAbsent(
        ConfigStatusMessage, () => ConfigStatusMessage.fromJsonFactory);

    return _thingsThingUIDConfigStatusGet(
        acceptLanguage: acceptLanguage?.toString(), thingUID: thingUID);
  }

  ///Gets thing config status.
  ///@param Accept-Language language
  ///@param thingUID thing
  @Get(path: '/things/{thingUID}/config/status')
  Future<chopper.Response<List<ConfigStatusMessage>>>
      _thingsThingUIDConfigStatusGet({
    @Header('Accept-Language') String? acceptLanguage,
    @Path('thingUID') required String? thingUID,
  });

  ///Gets thing's firmware status.
  ///@param Accept-Language language
  ///@param thingUID thing
  Future<chopper.Response<FirmwareStatusDTO>> thingsThingUIDFirmwareStatusGet({
    String? acceptLanguage,
    required String? thingUID,
  }) {
    generatedMapping.putIfAbsent(
        FirmwareStatusDTO, () => FirmwareStatusDTO.fromJsonFactory);

    return _thingsThingUIDFirmwareStatusGet(
        acceptLanguage: acceptLanguage?.toString(), thingUID: thingUID);
  }

  ///Gets thing's firmware status.
  ///@param Accept-Language language
  ///@param thingUID thing
  @Get(path: '/things/{thingUID}/firmware/status')
  Future<chopper.Response<FirmwareStatusDTO>> _thingsThingUIDFirmwareStatusGet({
    @Header('Accept-Language') String? acceptLanguage,
    @Path('thingUID') required String? thingUID,
  });

  ///Get all available firmwares for provided thing UID
  ///@param thingUID thingUID
  ///@param Accept-Language language
  Future<chopper.Response<List<FirmwareDTO>>> thingsThingUIDFirmwaresGet({
    required String? thingUID,
    String? acceptLanguage,
  }) {
    generatedMapping.putIfAbsent(
        FirmwareDTO, () => FirmwareDTO.fromJsonFactory);

    return _thingsThingUIDFirmwaresGet(
        thingUID: thingUID, acceptLanguage: acceptLanguage?.toString());
  }

  ///Get all available firmwares for provided thing UID
  ///@param thingUID thingUID
  ///@param Accept-Language language
  @Get(path: '/things/{thingUID}/firmwares')
  Future<chopper.Response<List<FirmwareDTO>>> _thingsThingUIDFirmwaresGet({
    @Path('thingUID') required String? thingUID,
    @Header('Accept-Language') String? acceptLanguage,
  });

  ///Gets thing status.
  ///@param Accept-Language language
  ///@param thingUID thing
  Future<chopper.Response<ThingStatusInfo>> thingsThingUIDStatusGet({
    String? acceptLanguage,
    required String? thingUID,
  }) {
    generatedMapping.putIfAbsent(
        ThingStatusInfo, () => ThingStatusInfo.fromJsonFactory);

    return _thingsThingUIDStatusGet(
        acceptLanguage: acceptLanguage?.toString(), thingUID: thingUID);
  }

  ///Gets thing status.
  ///@param Accept-Language language
  ///@param thingUID thing
  @Get(path: '/things/{thingUID}/status')
  Future<chopper.Response<ThingStatusInfo>> _thingsThingUIDStatusGet({
    @Header('Accept-Language') String? acceptLanguage,
    @Path('thingUID') required String? thingUID,
  });

  ///Sets the thing enabled status.
  ///@param Accept-Language language
  ///@param thingUID thing
  Future<chopper.Response<EnrichedThingDTO>> thingsThingUIDEnablePut({
    String? acceptLanguage,
    required String? thingUID,
    required String? body,
  }) {
    generatedMapping.putIfAbsent(
        EnrichedThingDTO, () => EnrichedThingDTO.fromJsonFactory);

    return _thingsThingUIDEnablePut(
        acceptLanguage: acceptLanguage?.toString(),
        thingUID: thingUID,
        body: body);
  }

  ///Sets the thing enabled status.
  ///@param Accept-Language language
  ///@param thingUID thing
  @Put(
    path: '/things/{thingUID}/enable',
    optionalBody: true,
  )
  Future<chopper.Response<EnrichedThingDTO>> _thingsThingUIDEnablePut({
    @Header('Accept-Language') String? acceptLanguage,
    @Path('thingUID') required String? thingUID,
    @Body() required String? body,
  });

  ///Updates thing's configuration.
  ///@param Accept-Language language
  ///@param thingUID thing
  Future<chopper.Response<EnrichedThingDTO>> thingsThingUIDConfigPut({
    String? acceptLanguage,
    required String? thingUID,
    required Object? body,
  }) {
    generatedMapping.putIfAbsent(
        EnrichedThingDTO, () => EnrichedThingDTO.fromJsonFactory);

    return _thingsThingUIDConfigPut(
        acceptLanguage: acceptLanguage?.toString(),
        thingUID: thingUID,
        body: body);
  }

  ///Updates thing's configuration.
  ///@param Accept-Language language
  ///@param thingUID thing
  @Put(
    path: '/things/{thingUID}/config',
    optionalBody: true,
  )
  Future<chopper.Response<EnrichedThingDTO>> _thingsThingUIDConfigPut({
    @Header('Accept-Language') String? acceptLanguage,
    @Path('thingUID') required String? thingUID,
    @Body() required Object? body,
  });

  ///Update thing firmware.
  ///@param Accept-Language language
  ///@param thingUID thing
  ///@param firmwareVersion version
  Future<chopper.Response> thingsThingUIDFirmwareFirmwareVersionPut({
    String? acceptLanguage,
    required String? thingUID,
    required String? firmwareVersion,
  }) {
    return _thingsThingUIDFirmwareFirmwareVersionPut(
        acceptLanguage: acceptLanguage?.toString(),
        thingUID: thingUID,
        firmwareVersion: firmwareVersion);
  }

  ///Update thing firmware.
  ///@param Accept-Language language
  ///@param thingUID thing
  ///@param firmwareVersion version
  @Put(
    path: '/things/{thingUID}/firmware/{firmwareVersion}',
    optionalBody: true,
  )
  Future<chopper.Response> _thingsThingUIDFirmwareFirmwareVersionPut({
    @Header('Accept-Language') String? acceptLanguage,
    @Path('thingUID') required String? thingUID,
    @Path('firmwareVersion') required String? firmwareVersion,
  });

  ///Gets all available thing types without config description, channels and properties.
  ///@param Accept-Language language
  ///@param bindingId filter by binding Id
  Future<chopper.Response<List<StrippedThingTypeDTO>>> thingTypesGet({
    String? acceptLanguage,
    String? bindingId,
  }) {
    generatedMapping.putIfAbsent(
        StrippedThingTypeDTO, () => StrippedThingTypeDTO.fromJsonFactory);

    return _thingTypesGet(
        acceptLanguage: acceptLanguage?.toString(), bindingId: bindingId);
  }

  ///Gets all available thing types without config description, channels and properties.
  ///@param Accept-Language language
  ///@param bindingId filter by binding Id
  @Get(path: '/thing-types')
  Future<chopper.Response<List<StrippedThingTypeDTO>>> _thingTypesGet({
    @Header('Accept-Language') String? acceptLanguage,
    @Query('bindingId') String? bindingId,
  });

  ///Gets thing type by UID.
  ///@param thingTypeUID thingTypeUID
  ///@param Accept-Language language
  Future<chopper.Response<ThingTypeDTO>> thingTypesThingTypeUIDGet({
    required String? thingTypeUID,
    String? acceptLanguage,
  }) {
    generatedMapping.putIfAbsent(
        ThingTypeDTO, () => ThingTypeDTO.fromJsonFactory);

    return _thingTypesThingTypeUIDGet(
        thingTypeUID: thingTypeUID, acceptLanguage: acceptLanguage?.toString());
  }

  ///Gets thing type by UID.
  ///@param thingTypeUID thingTypeUID
  ///@param Accept-Language language
  @Get(path: '/thing-types/{thingTypeUID}')
  Future<chopper.Response<ThingTypeDTO>> _thingTypesThingTypeUIDGet({
    @Path('thingTypeUID') required String? thingTypeUID,
    @Header('Accept-Language') String? acceptLanguage,
  });

  ///Gets information about the runtime, the API version and links to resources.
  Future<chopper.Response<RootBean>> get() {
    generatedMapping.putIfAbsent(RootBean, () => RootBean.fromJsonFactory);

    return _get();
  }

  ///Gets information about the runtime, the API version and links to resources.
  @Get(path: '/')
  Future<chopper.Response<RootBean>> _get();

  ///Gets information about the system.
  Future<chopper.Response<SystemInfoBean>> systeminfoGet() {
    generatedMapping.putIfAbsent(
        SystemInfoBean, () => SystemInfoBean.fromJsonFactory);

    return _systeminfoGet();
  }

  ///Gets information about the system.
  @Get(path: '/systeminfo')
  Future<chopper.Response<SystemInfoBean>> _systeminfoGet();

  ///Get all supported dimensions and their system units.
  Future<chopper.Response<UoMInfoBean>> systeminfoUomGet() {
    generatedMapping.putIfAbsent(
        UoMInfoBean, () => UoMInfoBean.fromJsonFactory);

    return _systeminfoUomGet();
  }

  ///Get all supported dimensions and their system units.
  @Get(path: '/systeminfo/uom')
  Future<chopper.Response<UoMInfoBean>> _systeminfoUomGet();

  ///Creates a sitemap event subscription.
  Future<chopper.Response> sitemapsEventsSubscribePost() {
    return _sitemapsEventsSubscribePost();
  }

  ///Creates a sitemap event subscription.
  @Post(
    path: '/sitemaps/events/subscribe',
    optionalBody: true,
  )
  Future<chopper.Response> _sitemapsEventsSubscribePost();

  ///Polls the data for a sitemap.
  ///@param Accept-Language language
  ///@param sitemapname sitemap name
  ///@param pageid page id
  ///@param subscriptionid subscriptionid
  ///@param includeHidden include hidden widgets
  Future<chopper.Response<PageDTO>> sitemapsSitemapnamePageidGet({
    String? acceptLanguage,
    required String? sitemapname,
    required String? pageid,
    String? subscriptionid,
    bool? includeHidden,
  }) {
    generatedMapping.putIfAbsent(PageDTO, () => PageDTO.fromJsonFactory);

    return _sitemapsSitemapnamePageidGet(
        acceptLanguage: acceptLanguage?.toString(),
        sitemapname: sitemapname,
        pageid: pageid,
        subscriptionid: subscriptionid,
        includeHidden: includeHidden);
  }

  ///Polls the data for a sitemap.
  ///@param Accept-Language language
  ///@param sitemapname sitemap name
  ///@param pageid page id
  ///@param subscriptionid subscriptionid
  ///@param includeHidden include hidden widgets
  @Get(path: '/sitemaps/{sitemapname}/{pageid}')
  Future<chopper.Response<PageDTO>> _sitemapsSitemapnamePageidGet({
    @Header('Accept-Language') String? acceptLanguage,
    @Path('sitemapname') required String? sitemapname,
    @Path('pageid') required String? pageid,
    @Query('subscriptionid') String? subscriptionid,
    @Query('includeHidden') bool? includeHidden,
  });

  ///Get sitemap by name.
  ///@param Accept-Language language
  ///@param sitemapname sitemap name
  ///@param type
  ///@param jsoncallback
  ///@param includeHidden include hidden widgets
  Future<chopper.Response<SitemapDTO>> sitemapsSitemapnameGet({
    String? acceptLanguage,
    required String? sitemapname,
    String? type,
    String? jsoncallback,
    bool? includeHidden,
  }) {
    generatedMapping.putIfAbsent(SitemapDTO, () => SitemapDTO.fromJsonFactory);

    return _sitemapsSitemapnameGet(
        acceptLanguage: acceptLanguage?.toString(),
        sitemapname: sitemapname,
        type: type,
        jsoncallback: jsoncallback,
        includeHidden: includeHidden);
  }

  ///Get sitemap by name.
  ///@param Accept-Language language
  ///@param sitemapname sitemap name
  ///@param type
  ///@param jsoncallback
  ///@param includeHidden include hidden widgets
  @Get(path: '/sitemaps/{sitemapname}')
  Future<chopper.Response<SitemapDTO>> _sitemapsSitemapnameGet({
    @Header('Accept-Language') String? acceptLanguage,
    @Path('sitemapname') required String? sitemapname,
    @Query('type') String? type,
    @Query('jsoncallback') String? jsoncallback,
    @Query('includeHidden') bool? includeHidden,
  });

  ///Get sitemap events.
  ///@param subscriptionid subscription id
  ///@param sitemap sitemap name
  ///@param pageid page id
  Future<chopper.Response> sitemapsEventsSubscriptionidGet({
    required String? subscriptionid,
    String? sitemap,
    String? pageid,
  }) {
    return _sitemapsEventsSubscriptionidGet(
        subscriptionid: subscriptionid, sitemap: sitemap, pageid: pageid);
  }

  ///Get sitemap events.
  ///@param subscriptionid subscription id
  ///@param sitemap sitemap name
  ///@param pageid page id
  @Get(path: '/sitemaps/events/{subscriptionid}')
  Future<chopper.Response> _sitemapsEventsSubscriptionidGet({
    @Path('subscriptionid') required String? subscriptionid,
    @Query('sitemap') String? sitemap,
    @Query('pageid') String? pageid,
  });

  ///Get all available sitemaps.
  Future<chopper.Response<List<SitemapDTO>>> sitemapsGet() {
    generatedMapping.putIfAbsent(SitemapDTO, () => SitemapDTO.fromJsonFactory);

    return _sitemapsGet();
  }

  ///Get all available sitemaps.
  @Get(path: '/sitemaps')
  Future<chopper.Response<List<SitemapDTO>>> _sitemapsGet();

  ///Initiates a new item state tracker connection
  Future<chopper.Response> eventsStatesGet() {
    return _eventsStatesGet();
  }

  ///Initiates a new item state tracker connection
  @Get(path: '/events/states')
  Future<chopper.Response> _eventsStatesGet();

  ///Get all events.
  ///@param topics topics
  Future<chopper.Response> eventsGet({String? topics}) {
    return _eventsGet(topics: topics);
  }

  ///Get all events.
  ///@param topics topics
  @Get(path: '/events')
  Future<chopper.Response> _eventsGet({@Query('topics') String? topics});

  ///Changes the list of items a SSE connection will receive state updates to.
  ///@param connectionId
  Future<chopper.Response> eventsStatesConnectionIdPost({
    required String? connectionId,
    required List<String>? body,
  }) {
    return _eventsStatesConnectionIdPost(
        connectionId: connectionId, body: body);
  }

  ///Changes the list of items a SSE connection will receive state updates to.
  ///@param connectionId
  @Post(
    path: '/events/states/{connectionId}',
    optionalBody: true,
  )
  Future<chopper.Response> _eventsStatesConnectionIdPost({
    @Path('connectionId') required String? connectionId,
    @Body() required List<String>? body,
  });

  ///Get a single transformation
  ///@param uid Transformation UID
  Future<chopper.Response<Transformation>> transformationsUidGet(
      {required String? uid}) {
    generatedMapping.putIfAbsent(
        Transformation, () => Transformation.fromJsonFactory);

    return _transformationsUidGet(uid: uid);
  }

  ///Get a single transformation
  ///@param uid Transformation UID
  @Get(path: '/transformations/{uid}')
  Future<chopper.Response<Transformation>> _transformationsUidGet(
      {@Path('uid') required String? uid});

  ///Put a single transformation
  ///@param uid Transformation UID
  Future<chopper.Response> transformationsUidPut({
    required String? uid,
    required TransformationDTO? body,
  }) {
    return _transformationsUidPut(uid: uid, body: body);
  }

  ///Put a single transformation
  ///@param uid Transformation UID
  @Put(
    path: '/transformations/{uid}',
    optionalBody: true,
  )
  Future<chopper.Response> _transformationsUidPut({
    @Path('uid') required String? uid,
    @Body() required TransformationDTO? body,
  });

  ///Get a single transformation
  ///@param uid Transformation UID
  Future<chopper.Response> transformationsUidDelete({required String? uid}) {
    return _transformationsUidDelete(uid: uid);
  }

  ///Get a single transformation
  ///@param uid Transformation UID
  @Delete(path: '/transformations/{uid}')
  Future<chopper.Response> _transformationsUidDelete(
      {@Path('uid') required String? uid});

  ///Get all transformation services
  Future<chopper.Response<List<String>>> transformationsServicesGet() {
    return _transformationsServicesGet();
  }

  ///Get all transformation services
  @Get(path: '/transformations/services')
  Future<chopper.Response<List<String>>> _transformationsServicesGet();

  ///Get a list of all transformations
  Future<chopper.Response<List<TransformationDTO>>> transformationsGet() {
    generatedMapping.putIfAbsent(
        TransformationDTO, () => TransformationDTO.fromJsonFactory);

    return _transformationsGet();
  }

  ///Get a list of all transformations
  @Get(path: '/transformations')
  Future<chopper.Response<List<TransformationDTO>>> _transformationsGet();

  ///Get all registered UI components in the specified namespace.
  ///@param namespace
  ///@param summary summary fields only
  Future<chopper.Response<List<RootUIComponent>>> uiComponentsNamespaceGet({
    required String? namespace,
    bool? summary,
  }) {
    generatedMapping.putIfAbsent(
        RootUIComponent, () => RootUIComponent.fromJsonFactory);

    return _uiComponentsNamespaceGet(namespace: namespace, summary: summary);
  }

  ///Get all registered UI components in the specified namespace.
  ///@param namespace
  ///@param summary summary fields only
  @Get(path: '/ui/components/{namespace}')
  Future<chopper.Response<List<RootUIComponent>>> _uiComponentsNamespaceGet({
    @Path('namespace') required String? namespace,
    @Query('summary') bool? summary,
  });

  ///Add a UI component in the specified namespace.
  ///@param namespace
  Future<chopper.Response<RootUIComponent>> uiComponentsNamespacePost({
    required String? namespace,
    required RootUIComponent? body,
  }) {
    generatedMapping.putIfAbsent(
        RootUIComponent, () => RootUIComponent.fromJsonFactory);

    return _uiComponentsNamespacePost(namespace: namespace, body: body);
  }

  ///Add a UI component in the specified namespace.
  ///@param namespace
  @Post(
    path: '/ui/components/{namespace}',
    optionalBody: true,
  )
  Future<chopper.Response<RootUIComponent>> _uiComponentsNamespacePost({
    @Path('namespace') required String? namespace,
    @Body() required RootUIComponent? body,
  });

  ///Get a specific UI component in the specified namespace.
  ///@param namespace
  ///@param componentUID
  Future<chopper.Response<RootUIComponent>>
      uiComponentsNamespaceComponentUIDGet({
    required String? namespace,
    required String? componentUID,
  }) {
    generatedMapping.putIfAbsent(
        RootUIComponent, () => RootUIComponent.fromJsonFactory);

    return _uiComponentsNamespaceComponentUIDGet(
        namespace: namespace, componentUID: componentUID);
  }

  ///Get a specific UI component in the specified namespace.
  ///@param namespace
  ///@param componentUID
  @Get(path: '/ui/components/{namespace}/{componentUID}')
  Future<chopper.Response<RootUIComponent>>
      _uiComponentsNamespaceComponentUIDGet({
    @Path('namespace') required String? namespace,
    @Path('componentUID') required String? componentUID,
  });

  ///Update a specific UI component in the specified namespace.
  ///@param namespace
  ///@param componentUID
  Future<chopper.Response<RootUIComponent>>
      uiComponentsNamespaceComponentUIDPut({
    required String? namespace,
    required String? componentUID,
    required RootUIComponent? body,
  }) {
    generatedMapping.putIfAbsent(
        RootUIComponent, () => RootUIComponent.fromJsonFactory);

    return _uiComponentsNamespaceComponentUIDPut(
        namespace: namespace, componentUID: componentUID, body: body);
  }

  ///Update a specific UI component in the specified namespace.
  ///@param namespace
  ///@param componentUID
  @Put(
    path: '/ui/components/{namespace}/{componentUID}',
    optionalBody: true,
  )
  Future<chopper.Response<RootUIComponent>>
      _uiComponentsNamespaceComponentUIDPut({
    @Path('namespace') required String? namespace,
    @Path('componentUID') required String? componentUID,
    @Body() required RootUIComponent? body,
  });

  ///Remove a specific UI component in the specified namespace.
  ///@param namespace
  ///@param componentUID
  Future<chopper.Response> uiComponentsNamespaceComponentUIDDelete({
    required String? namespace,
    required String? componentUID,
  }) {
    return _uiComponentsNamespaceComponentUIDDelete(
        namespace: namespace, componentUID: componentUID);
  }

  ///Remove a specific UI component in the specified namespace.
  ///@param namespace
  ///@param componentUID
  @Delete(path: '/ui/components/{namespace}/{componentUID}')
  Future<chopper.Response> _uiComponentsNamespaceComponentUIDDelete({
    @Path('namespace') required String? namespace,
    @Path('componentUID') required String? componentUID,
  });

  ///Get all registered UI tiles.
  Future<chopper.Response<List<TileDTO>>> uiTilesGet() {
    generatedMapping.putIfAbsent(TileDTO, () => TileDTO.fromJsonFactory);

    return _uiTilesGet();
  }

  ///Get all registered UI tiles.
  @Get(path: '/ui/tiles')
  Future<chopper.Response<List<TileDTO>>> _uiTilesGet();

  ///Gets the default voice.
  Future<chopper.Response<VoiceDTO>> voiceDefaultvoiceGet() {
    generatedMapping.putIfAbsent(VoiceDTO, () => VoiceDTO.fromJsonFactory);

    return _voiceDefaultvoiceGet();
  }

  ///Gets the default voice.
  @Get(path: '/voice/defaultvoice')
  Future<chopper.Response<VoiceDTO>> _voiceDefaultvoiceGet();

  ///Gets a single interpreter.
  ///@param Accept-Language language
  ///@param id interpreter id
  Future<chopper.Response<List<HumanLanguageInterpreterDTO>>>
      voiceInterpretersIdGet({
    String? acceptLanguage,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(HumanLanguageInterpreterDTO,
        () => HumanLanguageInterpreterDTO.fromJsonFactory);

    return _voiceInterpretersIdGet(
        acceptLanguage: acceptLanguage?.toString(), id: id);
  }

  ///Gets a single interpreter.
  ///@param Accept-Language language
  ///@param id interpreter id
  @Get(path: '/voice/interpreters/{id}')
  Future<chopper.Response<List<HumanLanguageInterpreterDTO>>>
      _voiceInterpretersIdGet({
    @Header('Accept-Language') String? acceptLanguage,
    @Path('id') required String? id,
  });

  ///Get the list of all interpreters.
  ///@param Accept-Language language
  Future<chopper.Response<List<HumanLanguageInterpreterDTO>>>
      voiceInterpretersGet({String? acceptLanguage}) {
    generatedMapping.putIfAbsent(HumanLanguageInterpreterDTO,
        () => HumanLanguageInterpreterDTO.fromJsonFactory);

    return _voiceInterpretersGet(acceptLanguage: acceptLanguage?.toString());
  }

  ///Get the list of all interpreters.
  ///@param Accept-Language language
  @Get(path: '/voice/interpreters')
  Future<chopper.Response<List<HumanLanguageInterpreterDTO>>>
      _voiceInterpretersGet(
          {@Header('Accept-Language') String? acceptLanguage});

  ///Sends a text to the default human language interpreter.
  ///@param Accept-Language language
  Future<chopper.Response> voiceInterpretersPost({
    String? acceptLanguage,
    required String? body,
  }) {
    return _voiceInterpretersPost(
        acceptLanguage: acceptLanguage?.toString(), body: body);
  }

  ///Sends a text to the default human language interpreter.
  ///@param Accept-Language language
  @Post(
    path: '/voice/interpreters',
    optionalBody: true,
  )
  Future<chopper.Response> _voiceInterpretersPost({
    @Header('Accept-Language') String? acceptLanguage,
    @Body() required String? body,
  });

  ///Get the list of all voices.
  Future<chopper.Response<List<VoiceDTO>>> voiceVoicesGet() {
    generatedMapping.putIfAbsent(VoiceDTO, () => VoiceDTO.fromJsonFactory);

    return _voiceVoicesGet();
  }

  ///Get the list of all voices.
  @Get(path: '/voice/voices')
  Future<chopper.Response<List<VoiceDTO>>> _voiceVoicesGet();

  ///Sends a text to a given human language interpreter(s).
  ///@param Accept-Language language
  ///@param ids comma separated list of interpreter ids
  Future<chopper.Response> voiceInterpretersIdsPost({
    String? acceptLanguage,
    required List<String>? ids,
    required String? body,
  }) {
    return _voiceInterpretersIdsPost(
        acceptLanguage: acceptLanguage?.toString(), ids: ids, body: body);
  }

  ///Sends a text to a given human language interpreter(s).
  ///@param Accept-Language language
  ///@param ids comma separated list of interpreter ids
  @Post(
    path: '/voice/interpreters/{ids}',
    optionalBody: true,
  )
  Future<chopper.Response> _voiceInterpretersIdsPost({
    @Header('Accept-Language') String? acceptLanguage,
    @Path('ids') required List<String>? ids,
    @Body() required String? body,
  });

  ///Executes a simple dialog sequence without keyword spotting for a given audio source.
  ///@param Accept-Language language
  ///@param sourceId source ID
  ///@param sttId Speech-to-Text ID
  ///@param ttsId Text-to-Speech ID
  ///@param voiceId voice ID
  ///@param hliIds interpreter IDs
  ///@param sinkId audio sink ID
  ///@param listeningItem listening item
  Future<chopper.Response> voiceListenandanswerPost({
    String? acceptLanguage,
    String? sourceId,
    String? sttId,
    String? ttsId,
    String? voiceId,
    List<String>? hliIds,
    String? sinkId,
    String? listeningItem,
  }) {
    return _voiceListenandanswerPost(
        acceptLanguage: acceptLanguage?.toString(),
        sourceId: sourceId,
        sttId: sttId,
        ttsId: ttsId,
        voiceId: voiceId,
        hliIds: hliIds,
        sinkId: sinkId,
        listeningItem: listeningItem);
  }

  ///Executes a simple dialog sequence without keyword spotting for a given audio source.
  ///@param Accept-Language language
  ///@param sourceId source ID
  ///@param sttId Speech-to-Text ID
  ///@param ttsId Text-to-Speech ID
  ///@param voiceId voice ID
  ///@param hliIds interpreter IDs
  ///@param sinkId audio sink ID
  ///@param listeningItem listening item
  @Post(
    path: '/voice/listenandanswer',
    optionalBody: true,
  )
  Future<chopper.Response> _voiceListenandanswerPost({
    @Header('Accept-Language') String? acceptLanguage,
    @Query('sourceId') String? sourceId,
    @Query('sttId') String? sttId,
    @Query('ttsId') String? ttsId,
    @Query('voiceId') String? voiceId,
    @Query('hliIds') List<String>? hliIds,
    @Query('sinkId') String? sinkId,
    @Query('listeningItem') String? listeningItem,
  });

  ///Speaks a given text with a given voice through the given audio sink.
  ///@param voiceid voice id
  ///@param sinkid audio sink id
  ///@param volume volume level
  Future<chopper.Response> voiceSayPost({
    String? voiceid,
    String? sinkid,
    String? volume,
    required String? body,
  }) {
    return _voiceSayPost(
        voiceid: voiceid, sinkid: sinkid, volume: volume, body: body);
  }

  ///Speaks a given text with a given voice through the given audio sink.
  ///@param voiceid voice id
  ///@param sinkid audio sink id
  ///@param volume volume level
  @Post(
    path: '/voice/say',
    optionalBody: true,
  )
  Future<chopper.Response> _voiceSayPost({
    @Query('voiceid') String? voiceid,
    @Query('sinkid') String? sinkid,
    @Query('volume') String? volume,
    @Body() required String? body,
  });

  ///Start dialog processing for a given audio source.
  ///@param Accept-Language language
  ///@param sourceId source ID
  ///@param ksId keywork spotter ID
  ///@param sttId Speech-to-Text ID
  ///@param ttsId Text-to-Speech ID
  ///@param voiceId voice ID
  ///@param hliIds comma separated list of interpreter IDs
  ///@param sinkId audio sink ID
  ///@param keyword keyword
  ///@param listeningItem listening item
  Future<chopper.Response> voiceDialogStartPost({
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
    return _voiceDialogStartPost(
        acceptLanguage: acceptLanguage?.toString(),
        sourceId: sourceId,
        ksId: ksId,
        sttId: sttId,
        ttsId: ttsId,
        voiceId: voiceId,
        hliIds: hliIds,
        sinkId: sinkId,
        keyword: keyword,
        listeningItem: listeningItem);
  }

  ///Start dialog processing for a given audio source.
  ///@param Accept-Language language
  ///@param sourceId source ID
  ///@param ksId keywork spotter ID
  ///@param sttId Speech-to-Text ID
  ///@param ttsId Text-to-Speech ID
  ///@param voiceId voice ID
  ///@param hliIds comma separated list of interpreter IDs
  ///@param sinkId audio sink ID
  ///@param keyword keyword
  ///@param listeningItem listening item
  @Post(
    path: '/voice/dialog/start',
    optionalBody: true,
  )
  Future<chopper.Response> _voiceDialogStartPost({
    @Header('Accept-Language') String? acceptLanguage,
    @Query('sourceId') String? sourceId,
    @Query('ksId') String? ksId,
    @Query('sttId') String? sttId,
    @Query('ttsId') String? ttsId,
    @Query('voiceId') String? voiceId,
    @Query('hliIds') String? hliIds,
    @Query('sinkId') String? sinkId,
    @Query('keyword') String? keyword,
    @Query('listeningItem') String? listeningItem,
  });

  ///Stop dialog processing for a given audio source.
  ///@param sourceId source ID
  Future<chopper.Response> voiceDialogStopPost({String? sourceId}) {
    return _voiceDialogStopPost(sourceId: sourceId);
  }

  ///Stop dialog processing for a given audio source.
  ///@param sourceId source ID
  @Post(
    path: '/voice/dialog/stop',
    optionalBody: true,
  )
  Future<chopper.Response> _voiceDialogStopPost(
      {@Query('sourceId') String? sourceId});

  ///Get a single logger.
  ///@param loggerName logger name
  Future<chopper.Response<LoggerInfo>> loggingLoggerNameGet(
      {required String? loggerName}) {
    generatedMapping.putIfAbsent(LoggerInfo, () => LoggerInfo.fromJsonFactory);

    return _loggingLoggerNameGet(loggerName: loggerName);
  }

  ///Get a single logger.
  ///@param loggerName logger name
  @Get(path: '/logging/{loggerName}')
  Future<chopper.Response<LoggerInfo>> _loggingLoggerNameGet(
      {@Path('loggerName') required String? loggerName});

  ///Modify or add logger
  ///@param loggerName logger name
  Future<chopper.Response> loggingLoggerNamePut({
    required String? loggerName,
    required LoggerInfo? body,
  }) {
    return _loggingLoggerNamePut(loggerName: loggerName, body: body);
  }

  ///Modify or add logger
  ///@param loggerName logger name
  @Put(
    path: '/logging/{loggerName}',
    optionalBody: true,
  )
  Future<chopper.Response> _loggingLoggerNamePut({
    @Path('loggerName') required String? loggerName,
    @Body() required LoggerInfo? body,
  });

  ///Remove a single logger.
  ///@param loggerName logger name
  Future<chopper.Response> loggingLoggerNameDelete(
      {required String? loggerName}) {
    return _loggingLoggerNameDelete(loggerName: loggerName);
  }

  ///Remove a single logger.
  ///@param loggerName logger name
  @Delete(path: '/logging/{loggerName}')
  Future<chopper.Response> _loggingLoggerNameDelete(
      {@Path('loggerName') required String? loggerName});

  ///Get all loggers
  Future<chopper.Response<LoggerBean>> loggingGet() {
    generatedMapping.putIfAbsent(LoggerBean, () => LoggerBean.fromJsonFactory);

    return _loggingGet();
  }

  ///Get all loggers
  @Get(path: '/logging')
  Future<chopper.Response<LoggerBean>> _loggingGet();

  ///Gets all icon sets.
  ///@param Accept-Language language
  Future<chopper.Response<List<IconSet>>> iconsetsGet(
      {String? acceptLanguage}) {
    generatedMapping.putIfAbsent(IconSet, () => IconSet.fromJsonFactory);

    return _iconsetsGet(acceptLanguage: acceptLanguage?.toString());
  }

  ///Gets all icon sets.
  ///@param Accept-Language language
  @Get(path: '/iconsets')
  Future<chopper.Response<List<IconSet>>> _iconsetsGet(
      {@Header('Accept-Language') String? acceptLanguage});

  ///Gets the list of widget gallery items.
  ///@param galleryName gallery name e.g. 'community'
  Future<chopper.Response<List<GalleryWidgetsListItem>>>
      habpanelGalleryGalleryNameWidgetsGet({required String? galleryName}) {
    generatedMapping.putIfAbsent(
        GalleryWidgetsListItem, () => GalleryWidgetsListItem.fromJsonFactory);

    return _habpanelGalleryGalleryNameWidgetsGet(galleryName: galleryName);
  }

  ///Gets the list of widget gallery items.
  ///@param galleryName gallery name e.g. 'community'
  @Get(path: '/habpanel/gallery/{galleryName}/widgets')
  Future<chopper.Response<List<GalleryWidgetsListItem>>>
      _habpanelGalleryGalleryNameWidgetsGet(
          {@Path('galleryName') required String? galleryName});

  ///Gets the details about a widget gallery item.
  ///@param galleryName gallery name e.g. 'community'
  ///@param id id within the gallery
  Future<chopper.Response<GalleryItem>> habpanelGalleryGalleryNameWidgetsIdGet({
    required String? galleryName,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
        GalleryItem, () => GalleryItem.fromJsonFactory);

    return _habpanelGalleryGalleryNameWidgetsIdGet(
        galleryName: galleryName, id: id);
  }

  ///Gets the details about a widget gallery item.
  ///@param galleryName gallery name e.g. 'community'
  ///@param id id within the gallery
  @Get(path: '/habpanel/gallery/{galleryName}/widgets/{id}')
  Future<chopper.Response<GalleryItem>>
      _habpanelGalleryGalleryNameWidgetsIdGet({
    @Path('galleryName') required String? galleryName,
    @Path('id') required String? id,
  });
}

typedef $JsonFactory<T> = T Function(Map<String, dynamic> json);

class $CustomJsonDecoder {
  $CustomJsonDecoder(this.factories);

  final Map<Type, $JsonFactory> factories;

  dynamic decode<T>(dynamic entity) {
    if (entity is Iterable) {
      return _decodeList<T>(entity);
    }

    if (entity is T) {
      return entity;
    }

    if (isTypeOf<T, Map>()) {
      return entity;
    }

    if (isTypeOf<T, Iterable>()) {
      return entity;
    }

    if (entity is Map<String, dynamic>) {
      return _decodeMap<T>(entity);
    }

    return entity;
  }

  T _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! $JsonFactory<T>) {
      return throw "Could not find factory for type $T. Is '$T: $T.fromJsonFactory' included in the CustomJsonDecoder instance creation in bootstrapper.dart?";
    }

    return jsonFactory(values);
  }

  List<T> _decodeList<T>(Iterable values) =>
      values.where((v) => v != null).map<T>((v) => decode<T>(v) as T).toList();
}

class $JsonSerializableConverter extends chopper.JsonConverter {
  @override
  FutureOr<chopper.Response<ResultType>> convertResponse<ResultType, Item>(
      chopper.Response response) async {
    if (response.bodyString.isEmpty) {
      // In rare cases, when let's say 204 (no content) is returned -
      // we cannot decode the missing json with the result type specified
      return chopper.Response(response.base, null, error: response.error);
    }

    if (ResultType == String) {
      return response.copyWith();
    }

    if (ResultType == DateTime) {
      return response.copyWith(
          body: DateTime.parse((response.body as String).replaceAll('"', ''))
              as ResultType);
    }

    final jsonRes = await super.convertResponse(response);
    return jsonRes.copyWith<ResultType>(
        body: $jsonDecoder.decode<Item>(jsonRes.body) as ResultType);
  }
}

final $jsonDecoder = $CustomJsonDecoder(generatedMapping);
